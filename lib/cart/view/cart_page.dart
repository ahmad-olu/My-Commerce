import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_commerce/app/appwrite_const.dart';
import 'package:my_commerce/cart/cubit/cart_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_checkout/stripe_checkout.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const CartView();
  }
}

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    final checkOutStat =
        context.select((CartCubit value) => value.state.checkOutStatus);
    String checkOutVal() {
      switch (checkOutStat) {
        case CheckOutStatus.initial:
          return 'result here';
        case CheckOutStatus.success:
          return 'Success';
        case CheckOutStatus.redirected:
          return 'Redirected';
        case CheckOutStatus.canceled:
          return 'Cancelled';
        case CheckOutStatus.error:
          return 'Error';
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(18),
            child: Text(checkOutVal()),
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.orderItems.length,
                  itemBuilder: (context, index) {
                    final prod = state.orderItems[index];
                    return ListTile(
                      leading: Text('#${prod.price}'),
                      title: Text(prod.name),
                      subtitle: Text(prod.description),
                      trailing: InkWell(
                        onTap: () => _removeFromCart(context, prod.id!),
                        child: const Text(
                          '-',
                          textScaler: TextScaler.linear(3),
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(50),
                child: ElevatedButton(
                  onPressed: () => _checkOut(context),
                  child: Column(
                    children: [
                      const Text('Check Out'),
                      Text(
                        'Total: ${state.orderItems.fold(0.toDouble(), (previousValue, element) => element.price)}',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _removeFromCart(BuildContext context, String id) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        content: const Text('Are you sure you want to remove this ❔.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              context.read<CartCubit>().removeFromCart(id);
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> _checkOut(
    BuildContext context,
  ) async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog.adaptive(
        content: const Text('Are you sure you want to checkout this ❔.'),
        actions: [
          ElevatedButton(
            onPressed: () {
              context
                  .read<CartCubit>()
                  .stripePaymentCheckout(context, context.mounted);
              //stripePaymentCheckout(context, state);
              //Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  Future<void> stripePaymentCheckout(
    BuildContext context,
    CartState state,
  ) async {
    if (state.orderItems.isEmpty) {
      return;
    }
    final sessionId = await _createCheckoutSession(state);

    if (!context.mounted) {
      return;
    }
    log('got here');
    final res = await redirectToCheckout(
      context: context,
      sessionId: sessionId,
      publishableKey: AppwriteConst.publishableKey,
      successUrl: 'https://checkout.stripe.dev/success',
      canceledUrl: 'https://checkout.stripe.dev/cancel',
    );
    res.when(
      redirected: () => log('CheckOutStatus.redirected'),
      success: () => log('CheckOutStatus.success'),
      canceled: () => log('CheckOutStatus.canceled'),
      error: (error) => log('CheckOutStatus.error'),
    );
  }

  Future<String> _createCheckoutSession(CartState state) async {
    final url = Uri.parse('https://api.stripe.com/v1/checkout/sessions');

    var lineItems = '';
    var index = 0;

    for (final element in state.orderItems) {
      //final price = element.price.round().toString();
      final price = (element.price * 100).round().toString();
      lineItems +=
          '&line_items[$index][price_data][product_data][name]=${element.name}';
      lineItems += '&line_items[$index][price_data][unit_amount]=$price';
      lineItems += '&line_items[$index][price_data][currency]=EUR';
      lineItems += '&line_items[$index][quantity]=1';

      index++;
    }
    final res = await http.post(
      url,
      body:
          'success_url=https://checkout.stripe.dev/success&mode=payment$lineItems',
      headers: {
        'Authorization': 'Bearer ${AppwriteConst.secretKey}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
    );
    log(',,,,,,,,,,,,,,,,${res.body}');
    return json.decode(res.body)['id'] as String;
  }
}

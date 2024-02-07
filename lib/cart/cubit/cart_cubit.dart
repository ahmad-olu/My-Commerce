// ignore_for_file: use_string_buffers

import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:my_commerce/app/appwrite_const.dart';
import 'package:my_commerce/app/model/product.dart';
import 'package:http/http.dart' as http;
import 'package:stripe_checkout/stripe_checkout.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState.initial());

  void addToCart(Product value) {
    if (state.orderItems.contains(value)) {
      return;
    }
    emit(
      state.copyWith(
        orderItems: [...state.orderItems, value],
      ),
    );
  }

  void removeFromCart(String id) {
    final prod = state.orderItems.where((element) => element.id != id).toList();

    emit(state.copyWith(orderItems: prod));
  }

  Future<void> stripePaymentCheckout(BuildContext context, bool mounted) async {
    if (state.orderItems.isEmpty) {
      return;
    }
    final sessionId = await _createCheckoutSession();

    if (!mounted) {
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
      redirected: () =>
          emit(state.copyWith(checkOutStatus: CheckOutStatus.redirected)),
      success: () =>
          emit(state.copyWith(checkOutStatus: CheckOutStatus.success)),
      canceled: () =>
          emit(state.copyWith(checkOutStatus: CheckOutStatus.canceled)),
      error: (error) =>
          emit(state.copyWith(checkOutStatus: CheckOutStatus.error)),
    );
  }

  Future<String> _createCheckoutSession() async {
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

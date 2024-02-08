import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_commerce/app/model/product.dart';
import 'package:my_commerce/auth/bloc/bloc/auth_bloc.dart';
import 'package:my_commerce/cart/cubit/cart_cubit.dart';
import 'package:my_commerce/products/bloc/product_cubit/products_cubit.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProductView();
  }
}

class ProductView extends StatelessWidget {
  const ProductView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = context.select((AuthBloc value) => value.state);

    return Scaffold(
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 19),
              child: Column(
                children: [
                  Text('Welcome ${user.appwriteUser?.email ?? ""}'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Browse Collections'),
                      InkWell(
                        onTap: () => _goToCart(context),
                        child: Stack(
                          children: [
                            const Text('👜', textScaler: TextScaler.linear(2)),
                            Positioned(
                              right: 5,
                              child: Container(
                                decoration: const BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(100)),
                                ),
                                child: Text(
                                  '${context.select((CartCubit value) => value.state.orderItems.length)}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                  ),
                                  textScaler: const TextScaler.linear(1.2),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 600,
                    child: GridView.builder(
                      itemCount: state.products.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 2,
                      ),
                      itemBuilder: (context, index) {
                        final product = state.products[index];
                        // log('=====> $product');
                        return Column(
                          children: [
                            Card(
                              child: Image.network(
                                product.image,
                                height: 95,
                                width: double.maxFinite,
                                fit: BoxFit.fill,
                              ),
                            ),
                            Text('#${product.price}'),
                            Text(product.name),
                            // Text(product.description),
                            BlocBuilder<CartCubit, CartState>(
                              builder: (context, state) {
                                return ElevatedButton(
                                  onPressed: () => _addToCart(context, product),
                                  child: const Text('+'),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      floatingActionButton: (user.user != null &&
              user.user!.isAdmin != false &&
              user.appwriteUser != null)
          ? FloatingActionButton(
              onPressed: () => _createProduct(context),
              child: const Icon(Icons.add),
            )
          : null,
    );
  }

  void _addToCart(BuildContext context, Product value) {
    context.read<CartCubit>().addToCart(value);
  }

  void _goToCart(BuildContext context) {
    Navigator.pushNamed(context, '/cart_page');
  }

  void _createProduct(BuildContext context) {
    Navigator.pushNamed(context, '/create_product_page');
  }
}

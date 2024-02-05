import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_commerce/auth/bloc/bloc/auth_bloc.dart';

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
    log(user.user.toString());
    return Scaffold(
      body: SingleChildScrollView(
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
                    onTap: () {},
                    child: const Text('👜', textScaler: TextScaler.linear(2)),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 600,
                child: GridView.builder(
                  itemCount: 12,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 10,
                      child: Card(
                        child: Text('data $index'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: (user.user == null && user.appwriteUser == null)
          ? null
          : FloatingActionButton(
              onPressed: () {},
              child: const Icon(Icons.add),
            ),
    );
  }
}

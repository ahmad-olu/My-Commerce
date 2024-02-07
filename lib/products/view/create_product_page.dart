import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:my_commerce/auth/bloc/bloc/auth_bloc.dart';
import 'package:my_commerce/products/bloc/create_product_cubit/create_product_cubit.dart';

class CreateProductPage extends StatelessWidget {
  const CreateProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CreateProductCubit(),
      child: const CreateProductView(),
    );
  }
}

class CreateProductView extends StatefulWidget {
  const CreateProductView({super.key});

  @override
  State<CreateProductView> createState() => _CreateProductViewState();
}

class _CreateProductViewState extends State<CreateProductView> {
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateProductCubit, CreateProductState>(
      listener: (context, state) {
        if (state.hasError) {
          log('error => ${state.errorMessage}');
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: state.isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : Form(
                      key: key,
                      child: Column(
                        children: [
                          const SizedBox(height: 10),
                          const Text('Create Product'),
                          const SizedBox(height: 80),
                          if (state.image == null)
                            const Text('🖼️', textScaler: TextScaler.linear(5))
                          else
                            Image.file(
                              File(state.image!.path),
                              height: 130,
                            ),
                          const SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: () async {
                              context
                                  .read<CreateProductCubit>()
                                  .imageFile(await getProductImage());
                            },
                            child: const Text('Add Image'),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            onChanged: (value) => context
                                .read<CreateProductCubit>()
                                .nameStr(value),
                            decoration: const InputDecoration(
                              helperText: 'Title',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'title cant be empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            onChanged: (value) => context
                                .read<CreateProductCubit>()
                                .descriptionStr(value),
                            decoration: const InputDecoration(
                              helperText: 'Description',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'description cant be empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            onChanged: (value) => context
                                .read<CreateProductCubit>()
                                .priceDouble(double.tryParse(value) ?? 0.0),
                            decoration: const InputDecoration(
                              helperText: 'Price',
                              hintText: '12.5',
                            ),
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'price cant be empty';
                              }
                              // if (value.runtimeType == String) {
                              //   return 'the below field have to be float type';
                              // }
                              return null;
                            },
                          ),
                          const SizedBox(height: 5),
                          TextFormField(
                            onChanged: (value) => context
                                .read<CreateProductCubit>()
                                .categoryStr(value),
                            decoration: const InputDecoration(
                              helperText: 'Category',
                            ),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'category cant be empty';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 5),
                          ElevatedButton(
                            onPressed: () {
                              if (key.currentState!.validate()) {
                                context.read<CreateProductCubit>().upload();
                              }
                            },
                            child: const Text('Upload'),
                          ),
                        ],
                      ),
                    ),
            ),
          ),
        );
      },
    );
  }
}

Future<XFile?> getProductImage() async {
  final picker = ImagePicker();
  final image = await picker.pickImage(source: ImageSource.gallery);
  return image;
}

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_commerce/auth/bloc/cubit/reg_and_login_cubit.dart';

class SigInpPage extends StatelessWidget {
  const SigInpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SignInView();
  }
}

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RegAndLoginCubit, RegAndLoginState>(
      listener: (context, state) {
        if (state.isLoading) {
          log('sign up is Loading');
        }
        if (state.hasError) {
          log('sign up has error with => ${state.errorMessage}');
        }
      },
      builder: (context, state) {
        log(state.toString());
        return Scaffold(
          body: Form(
            key: key,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(state.isLoading ? 'isLoading' : 'isNotLoading'),
                  Text(state.hasError ? state.errorMessage! : 'hasNoError'),
                  const SizedBox(height: 20),
                  const Text('Sign In'),
                  const SizedBox(height: 20),
                  TextFormField(
                    decoration: InputDecoration(
                      helperText: 'Email',
                      enabled: !state.isLoading,
                    ),
                    onChanged: (value) =>
                        context.read<RegAndLoginCubit>().emailStr(value),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This can't ne empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      helperText: 'password',
                      enabled: !state.isLoading,
                    ),
                    onChanged: (value) =>
                        context.read<RegAndLoginCubit>().passwordStr(value),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "This can't ne empty";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 5),
                  ElevatedButton(
                    onPressed: state.isLoading
                        ? null
                        : () {
                            if (key.currentState!.validate()) {
                              context.read<RegAndLoginCubit>().login();
                            }
                          },
                    child: const Text('Sign In'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

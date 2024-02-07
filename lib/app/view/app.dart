import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_commerce/auth/bloc/bloc/auth_bloc.dart';
import 'package:my_commerce/auth/bloc/cubit/reg_and_login_cubit.dart';
import 'package:my_commerce/auth/view/sign_in.dart';
import 'package:my_commerce/auth/view/sign_up.dart';
import 'package:my_commerce/cart/cubit/cart_cubit.dart';
import 'package:my_commerce/cart/view/cart_page.dart';
import 'package:my_commerce/counter/counter.dart';
import 'package:my_commerce/l10n/l10n.dart';
import 'package:my_commerce/products/bloc/product_cubit/products_cubit.dart';
import 'package:my_commerce/products/view/create_product_page.dart';
import 'package:my_commerce/products/view/product_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()..add(GetUserDetails())),
        BlocProvider(
          create: (_) => RegAndLoginCubit(),
        ),
        BlocProvider(
          create: (_) => ProductsCubit()..getProducts(),
        ),
        BlocProvider(
          create: (_) => CartCubit(),
        ),
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          ),
          useMaterial3: true,
        ),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        routes: {
          '/': (context) => const ProductPage(),
          '/create_product_page': (context) => const CreateProductPage(),
          '/sign_up': (context) => const SignUpPage(),
          '/sign_in': (context) => const SigInpPage(),
          '/cart_page': (context) => const CartPage(),
        },
      ),
    );
  }
}

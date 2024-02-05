import 'package:flutter/material.dart';
import 'package:my_commerce/app/app.dart';
import 'package:my_commerce/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const App());
}

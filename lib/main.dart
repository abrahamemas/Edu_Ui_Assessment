import 'package:flutter/material.dart';
import 'bootstrap.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await bootstrap();
  runApp(const App());
}
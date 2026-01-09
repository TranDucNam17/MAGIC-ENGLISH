import 'package:flutter/material.dart';
import 'package:btl_magicenglish/features/splash/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'Magic English', home: const SplashScreen());
  }
}

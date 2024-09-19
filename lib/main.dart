import 'package:app_sawit/ui/splash_page/splash_page_view.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashPageView(),
      debugShowCheckedModeBanner: false,
    );
  }
}


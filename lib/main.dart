import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:post_app/colour/colour.dart';
import 'package:post_app/screen/home.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tweeter',
      theme: ThemeData(
        primaryColor: hitam,
      ),
      home: const Home(),
    );
  }
}

void main() {
  runApp(const MyApp());
}

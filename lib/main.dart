import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:post_app/colour/colour.dart';
import 'package:post_app/screen/home.dart';
import 'package:post_app/screen/search_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Forum',
      theme: ThemeData(
        primaryColor: hitam,
      ),
      initialRoute: '/', // Define initial route
      routes: {
        '/': (context) => Home(),
        '/search': (context) =>  const SearchPage(), // SearchPage route
      },
    );
  }
}

void main() {
  runApp(const MyApp());
}

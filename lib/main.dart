import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:post_app/screen/home.dart';
import 'package:post_app/screen/search_page.dart';
import 'package:post_app/screen/topic_detail.dart';
import 'package:post_app/services/data_service.dart';

import 'constant/colour.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final DataService _dataService =
      DataService(); // Instantiate your PostService implementation

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
        '/': (context) => Home(
              postService: _dataService,
            ),
        '/search': (context) => const SearchPage(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/topicDetail') {
          final Map<String, dynamic>? args =
              settings.arguments as Map<String, dynamic>?;
          if (args != null) {
            return MaterialPageRoute(
              builder: (context) => TopicDetail(
                topicData: {
                  'name': args['name'],
                  'userName': args['userName'],
                  'title': args['title'],
                  'content': args['content'],
                },
              ),
            );
          }
        }
        return null;
      },
    );
  }
}

void main() {
  runApp(MyApp());
}

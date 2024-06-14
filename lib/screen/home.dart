import 'package:flutter/material.dart';
import 'package:post_app/colour/colour.dart';
import 'package:post_app/screen/search_page.dart';
import 'package:post_app/widgets/topic_item.dart';
import 'package:post_app/model/post.dart';

import '../services/data_service.dart';

class Home extends StatelessWidget {
  Home({super.key});

  //  Create instance
  final DataService _dataService = DataService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hitam,
      appBar: _buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              'Topic',
              style: TextStyle(
                color: putih,
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Container(
            color: kelabuWithOpacity,
            height: 0.5,
          ),
          Expanded(
            child: FutureBuilder<List<Post>>(
              future: _dataService.fetchPosts(), // Use the instance of DataService to call fetchPosts
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No posts available'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data![index];
                      return TopicItem(
                        name: post.name,
                        userName: '@${post.username}',
                        title: post.title,
                        content: post.body,
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor:
          Colors.black, // Assuming hitam is defined as Colors.black
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white, // Assuming putih is defined as Colors.white
              size: 30,
            ),
            tooltip: 'Search post',
            onPressed: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const SearchPage(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    var begin = const Offset(1.0, 0.0);
                    var end = Offset.zero;
                    var curve = Curves.ease;

                    var tween = Tween(begin: begin, end: end)
                        .chain(CurveTween(curve: curve));

                    return SlideTransition(
                      position: animation.drive(tween),
                      child: child,
                    );
                  },
                ),
              );
            },
          ),
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: Colors.grey
              .withOpacity(0.5), // Assuming kelabuWithOpacity is defined
          height: 0.5,
        ),
      ),
    );
  }
}

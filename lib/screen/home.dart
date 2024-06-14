import 'package:flutter/material.dart';
import 'package:post_app/colour/colour.dart';
import 'package:post_app/widgets/topic_item.dart';
import 'package:post_app/model/post.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hitam,
      appBar: _buildAppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Text(
              'Topic',
              style: TextStyle(
                  color: putih, fontSize: 17, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            color: kelabuWithOpacity,
            height: 0.5,
          ),
          Expanded(
            child: FutureBuilder<List<Post>>(
              future: fetchPosts(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData) {
                  return const Center(child: Text('No posts available'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final post = snapshot.data![index];
                      return TopicItem(
                        name: 'User ${post.id}',
                        userName: '@User ${post.userId}',
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

  AppBar _buildAppBar() {
    return AppBar(
      elevation: 0,
      backgroundColor: hitam,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: IconButton(
            icon: const Icon(
              Icons.search,
              color: putih,
              size: 30,
            ),
            tooltip: 'Search post',
            color: putih,
            onPressed: () {},
          ),
        )
      ],
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: kelabuWithOpacity,
          height: 0.5,
        ),
      ),
    );
  }
}

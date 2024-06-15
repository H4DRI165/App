import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:post_app/screen/search_page.dart';
import 'package:post_app/widgets/topic_item.dart';
import 'package:post_app/model/post.dart';

import '../constant/colour.dart';
import '../services/data_service.dart';

class Home extends StatefulWidget {
  const Home({super.key, required this.postService});

  //  Create instance
  final PostService postService;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hitam,
      appBar: _buildAppBar(context),
      body: buildBody(),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
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
          color: Colors.grey.withOpacity(0.5),
          height: 0.5,
        ),
      ),
    );
  }

  Widget buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Topic',
                style: TextStyle(
                  color: putih,
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              GestureDetector(
                  onTap: () {
                    _refreshPosts();
                  },
                  child: const Icon(Icons.refresh, color: putih))
            ],
          ),
        ),
        Container(
          color: kelabuWithOpacity,
          height: 0.5,
        ),
        Expanded(
          child: _buildPostList(),
        ),
      ],
    );
  }

  Widget _buildPostList() {
    return FutureBuilder<List<Post>>(
      future: widget.postService.fetchPosts(),
      builder: (context, snapshot) {
        if (_isLoading || snapshot.connectionState == ConnectionState.waiting) {
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
                id: post.id.toString(),
                name: post.name,
                email: post.email,
                title: post.title,
                content: post.body,
              );
            },
          );
        }
      },
    );
  }

  void _refreshPosts() {
    setState(() {
      _isLoading = true;
    });

    widget.postService.fetchPosts().then((_) {
      setState(() {
        _isLoading = false;
      });
    }).catchError((error) {
      setState(() {
        _isLoading = false;
      });
      if (kDebugMode) {
        print('Error fetching posts: $error');
      }
    });
  }
}

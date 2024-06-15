import 'package:flutter/material.dart';
import 'package:post_app/widgets/comment_item.dart';
import 'package:post_app/widgets/topic_item.dart';

import '../constant/colour.dart';
import '../model/comment.dart';
import '../services/data_service.dart';

class TopicDetail extends StatelessWidget {
  final Map<String, String> topicData;

  //  Create instance
  final DataService _dataService = DataService();

  TopicDetail({
    super.key,
    required this.topicData,
  });

  @override
  Widget build(BuildContext context) {
    String id = topicData['id'] ?? '';

    return Scaffold(
      backgroundColor: hitam,
      appBar: buildAppBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopicItem(
            id: id,
            name: topicData['name'] ?? '',
            email: topicData['email'] ?? '',
            title: topicData['title'] ?? '',
            content: topicData['content'] ?? '',
            enableGesture: false,
            truncateTitleContent: false,
          ),
          buildRepostLike(),
          Container(
            color: kelabuWithOpacity,
            height: 0.5,
          ),
          buildLikeShare(),
          Container(
            color: kelabuWithOpacity,
            height: 0.5,
          ),
          Expanded(
            child: FutureBuilder<List<Comment>>(
              future: id.isNotEmpty ? _dataService.fetchCommentsForPost(id) : Future.value([]),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No comment available'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final comment = snapshot.data![index];
                      return CommentItem(
                        id: comment.id.toString(),
                        authorEmail: topicData['email'] ?? '',
                        comment: comment.body,
                        commenterEmail: comment.email,
                        truncateComment: true,
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

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: hitam,
      iconTheme: const IconThemeData(color: putih),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          size: 30,
        ),
        onPressed: () {
          Navigator.pop(context); // Navigate back
        },
      ),
      title: const Text(
        'Post',
        style: TextStyle(
          color: putih,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(1.0),
        child: Container(
          color: kelabuWithOpacity,
          height: 0.5,
        ),
      ),
    );
  }

  Padding buildLikeShare() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Icon(Icons.favorite_outline, color: putih, size: 25),
          SizedBox(width: 5),
          Text('Like', style: TextStyle(color: putih)),
          SizedBox(width: 10),
          Icon(Icons.share_outlined, color: putih, size: 25),
          Text('Share', style: TextStyle(color: putih)),
        ],
      ),
    );
  }

  Widget buildRepostLike() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          Text(
            '5',
            style: TextStyle(
              color: putih,
            ),
          ),
          SizedBox(width: 5),
          Text(
            'Reposts',
            style: TextStyle(
              color: kelabu,
            ),
          ),
          SizedBox(width: 10),
          Text(
            '5',
            style: TextStyle(
              color: putih,
            ),
          ),
          SizedBox(width: 5),
          Text(
            'Likes',
            style: TextStyle(
              color: kelabu,
            ),
          ),
        ],
      ),
    );
  }
}

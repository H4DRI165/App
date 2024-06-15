import 'package:flutter/material.dart';
import '../constant/colour.dart';
import '../screen/topic_detail.dart';

class TopicItem extends StatelessWidget {
  final String id;
  final String name;
  final String email;
  final String title;
  final String content;

  // Enable/disable the gesture detector
  final bool enableGesture;

  // To limit title and content words
  final bool truncateTitleContent;

  const TopicItem({
    super.key,
    required this.id,
    required this.name,
    required this.email,
    required this.title,
    required this.content,
    this.enableGesture = true, // Default to true
    this.truncateTitleContent = true, // Default to true
  });

  @override
  Widget build(BuildContext context) {
    Widget itemContent = Column(
      children: [
        Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: kelabu,
                      ),
                      child: const Icon(
                        Icons.person,
                        color: putih,
                        size: 30,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          name,
                          style: const TextStyle(color: putih),
                        ),
                        Text(
                          email,
                          style: const TextStyle(color: kelabu),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  truncateTitleContent ? _truncateString(title, 50) : title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                  maxLines: truncateTitleContent ? 1 : null,
                  overflow: truncateTitleContent ? TextOverflow.ellipsis : null,
                  textAlign: TextAlign.justify,
                ),
                const SizedBox(height: 20),
                Text(
                  truncateTitleContent
                      ? _truncateString(content.replaceAll('\n', ''), 200)
                      : content.replaceAll('\n', ''),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.normal,
                    fontSize: 13,
                  ),
                  maxLines: truncateTitleContent ? 3 : null,
                  overflow: truncateTitleContent ? TextOverflow.ellipsis : null,
                  textAlign: TextAlign.justify,
                ),
              ],
            ),
          ),
        ),
        Container(
          color: kelabuWithOpacity,
          height: 0.5,
        ),
      ],
    );

    // Wrap with GestureDetector only if enableGesture is true
    return enableGesture
        ? GestureDetector(
            onTap: () {
              // Navigate or perform action as needed
              _navigateToTopicDetail(context);
            },
            child: itemContent,
          )
        : itemContent;
  }

  void _navigateToTopicDetail(BuildContext context) {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => TopicDetail(
          topicData: {
            'id' : id,
            'name': name,
            'email': email,
            'title': title,
            'content': content,
          },
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = const Offset(1.0, 0.0);
          var end = Offset.zero;
          var curve = Curves.ease;
          var tween =
              Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
      ),
    );
  }

  String _truncateString(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }
}

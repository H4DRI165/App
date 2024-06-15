import 'package:flutter/material.dart';
import '../constant/colour.dart';

class CommentItem extends StatelessWidget {
  final String id;
  final String commenterEmail;
  final String authorEmail;
  final String comment;

  // To limit comments words
  final bool truncateComment;

  const CommentItem({
    super.key,
    required this.id,
    required this.authorEmail,
    required this.comment,
    required this.commenterEmail,
    this.truncateComment = true, // Default to true
  });

  @override
  Widget build(BuildContext context) {
    Widget itemContent = Column(
      children: [
        Material(
          color: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('User', style: TextStyle(color: putih)),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(commenterEmail,
                                style: const TextStyle(
                                    color: kelabu,
                                    overflow: TextOverflow.ellipsis)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          const Text('Replying to ',
                              style: TextStyle(color: kelabu)),
                          Expanded(
                            child: Text(authorEmail,
                                style: const TextStyle(
                                    color: biru,
                                    overflow: TextOverflow.ellipsis)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        truncateComment
                            ? _truncateString(comment.replaceAll('\n', ''), 200)
                            : comment.replaceAll('\n', ''),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 13,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
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

    return itemContent;
  }

  String _truncateString(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }
}

import 'package:flutter/material.dart';

import '../colour/colour.dart';

class TopicItem extends StatelessWidget {
  final String name;
  final String userName;
  final String title;
  final String content;

  const TopicItem({
    super.key,
    required this.name,
    required this.userName,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
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
                          userName,
                          style: const TextStyle(color: kelabu),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  _truncateString(title, 50),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis, // Truncate with ellipsis (...) if overflow
                  style: const TextStyle(
                      color: putih, fontWeight: FontWeight.bold, fontSize: 15, ),
                ),
                const SizedBox(height: 10),
                Text(
                  _truncateString(content.replaceAll('\n', ''), 200),
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                      color: putih,
                      fontWeight: FontWeight.normal,
                      fontSize: 13),
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
  }

  String _truncateString(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }
}



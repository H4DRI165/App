import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:post_app/widgets/topic_item.dart';

import '../constant/colour.dart';
import '../model/post.dart';
import '../services/data_service.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final DataService _dataService = DataService();
  List<Post> searchResults = []; // Hold filtered post
  String query = ''; //  Hold user input

  void searchPosts(String query) async {
    try {
      var results = await _dataService.searchPosts(query);
      setState(() {
        searchResults = results;
      });
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching posts: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: hitam,
      appBar: buildAppBar(context),
      body: _buildSearchResults(),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: hitam,
      iconTheme: const IconThemeData(color: putih),
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          size: 30, // Adjust the size as needed
        ),
        onPressed: () {
          Navigator.pop(context); // Navigate back
        },
      ),
      title: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: kelabuWithOpacity,
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          onChanged: (value) {
            setState(() {
              query = value;
            });

            // Search when input change
            searchPosts(query);
          },
          style: const TextStyle(color: biru),
          decoration: const InputDecoration(
            contentPadding: EdgeInsets.all(0),
            border: InputBorder.none,
            hintText: 'Search',
            hintStyle: TextStyle(color: kelabu),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchResults() {
    if (searchResults.isEmpty && query.isNotEmpty) {
      return const Center(
        child: Text(
          'No results found.',
          style: TextStyle(color: putih),
        ),
      );
    } else if (searchResults.isEmpty && query.isEmpty) {
      return const Center(
        child: Text(
          'Enter a post title to search.',
          style: TextStyle(color: putih),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: searchResults.length,
        itemBuilder: (context, index) {
          final post = searchResults[index];
          return TopicItem(
            id: post.id.toString(),
            name: post.name,
            email: '@${post.email}',
            title: post.title,
            content: post.body,
          );
        },
      );
    }
  }
}

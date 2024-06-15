import 'dart:convert';
import 'package:connectivity/connectivity.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../constant/colour.dart';
import '../model/comment.dart';
import '../model/post.dart';
import 'package:http/http.dart' as http;

abstract class PostService {
  Future<List<Post>> fetchPosts();
  Future<List<Post>> searchPosts(String query);
  Future<List<Comment>> fetchCommentsForPost(String id);
}

class DataService implements PostService {
  // Private constructor
  DataService._();

  // Singleton instance
  static final DataService _instance = DataService._();

  // Factory method to provide access to the singleton instance
  factory DataService() {
    return _instance;
  }

  Future<bool> _isOnline() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult != ConnectivityResult.none;
  }

  //  Fetch posts
  @override
  Future<List<Post>> fetchPosts() async {
    if (await _isOnline()) {
      try {
        // Fetch users data
        final usersResponse = await http
            .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

        if (usersResponse.statusCode == 200) {
          List<dynamic> usersJson = json.decode(usersResponse.body);

          // Create a map of id to user data for quick lookup
          Map<int, Map<String, dynamic>> userDataMap = {};
          for (var user in usersJson) {
            userDataMap[user['id']] = user;
          }

          // Fetch posts data
          final postsResponse = await http
              .get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));

          if (postsResponse.statusCode == 200) {
            List<dynamic> postsJson = json.decode(postsResponse.body);

            // Filter posts to include only those with id existing in userDataMap
            List<Post> posts = postsJson
                .where((postJson) => userDataMap.containsKey(postJson['id']))
                .map((postJson) {
              int id = postJson['id'];
              Map<String, dynamic> user = userDataMap[id] ?? {};
              return Post.fromJson(postJson)
                ..name = user['name'] ?? ''
                ..email = user['email'] ?? '';
            }).toList();

            return posts;
          } else {
            throw Exception('Failed to load posts');
          }
        } else {
          throw Exception('Failed to load users');
        }
      } catch (e) {
        throw Exception('Failed to fetch data: $e');
      }
    } else {
      // Handle no internet scenario
      await Future.delayed(
        const Duration(seconds: 5), // Buffer for 5 seconds
      );
      Fluttertoast.showToast(
          msg: 'No internet connection. Please try again.',
          toastLength: Toast.LENGTH_SHORT,
          textColor: putih);
      throw Exception('No internet connection');
    }
  }

  @override
  Future<List<Post>> searchPosts(String query) async {
    try {
      List<Post> posts = await fetchPosts();

      // Return an empty list when query is empty
      if (query.isEmpty) {
        return [];
      }

      // Filter posts based on query
      List<Post> filteredPosts = posts
          .where(
              (post) => post.title.toLowerCase().contains(query.toLowerCase()))
          .toList();

      return filteredPosts;
    } catch (e) {
      throw Exception('Failed to search posts: $e');
    }
  }

  @override
  Future<List<Comment>> fetchCommentsForPost(String id) async {
    try {
      final commentsResponse = await http.get(Uri.parse(
          'https://jsonplaceholder.typicode.com/comments?postId=$id'));

      if (commentsResponse.statusCode == 200) {
        List<dynamic> commentsJson = json.decode(commentsResponse.body);
        List<Comment> comments = commentsJson
            .map((commentJson) => Comment.fromJson(commentJson))
            .toList();

        return comments;
      } else {
        throw Exception('Failed to load comments for post');
      }
    } catch (e) {
      throw Exception('Failed to fetch comments: $e');
    }
  }
}

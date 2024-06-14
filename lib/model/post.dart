
class Post {
  final int userId, id;
  final String title, body;
  String name, username;

  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,

    // Initialize with empty string
    this.name = '',
    this.username = '',
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      userId: json['userId'],
      id: json['id'],
      title: json['title'],
      body: json['body'],
    );
  }
}

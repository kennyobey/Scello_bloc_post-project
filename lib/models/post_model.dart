class Post {
  final int id;
  final String title;
  final String body;
  final int userId;

  Post({required this.id, required this.title, required this.body, required this.userId});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      title: json['title'],
      body: json['body'],
      userId: json['userId'],
    );
  }
}

class Comment {
  final int id;
  final String name;
  final String body;

  Comment({required this.id, required this.name, required this.body});

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      name: json['name'],
      body: json['body'],
    );
  }
}

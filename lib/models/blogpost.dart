class BlogPost {
  int id;
  String title;
  String content;
  DateTime createdAt;
  DateTime editedAt;
  int likes;
  bool isLikedByMe = false;

  BlogPost({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.editedAt,
    required this.likes,
  });

  factory BlogPost.fromJson(Map<String, dynamic> json) {
    return BlogPost(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      editedAt: DateTime.parse(json['editedAt']),
      likes: json['likes'],
    );
  }

  String get publishedDateString => "${createdAt.day}.${createdAt.month}.${createdAt.year}";
}

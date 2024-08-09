class Blog {
  int id;
  String title;
  String content;
  DateTime publishedAt;
  bool isLikedByMe = false;

  Blog({
    this.id = 0,
    required this.title,
    required this.content,
    required this.publishedAt,
  });

  String get publishedDateString => "${publishedAt.day}.${publishedAt.month}.${publishedAt.year}";

  // Factory method to create a Blog instance from JSON
  factory Blog.fromJson(Map<String, dynamic> json) {
    return Blog(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      publishedAt: DateTime.parse(json['publishedAt']),
      // isLikedByMe: json['isLikedByMe'] ?? false,
    );
  }

  // Method to convert a Blog instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      // 'publishedAt': publishedAt.toIso8601String(),
      // 'isLikedByMe': isLikedByMe,
    };
  }
}

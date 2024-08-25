class Blog {
  int id;
  String title;
  String content;
  DateTime publishedAt;
  bool isLikedByMe = false;
  String? imagePath;

  Blog({
    this.id = 0,
    required this.title,
    required this.content,
    required this.publishedAt,
    this.imagePath,
  });

  String get publishedDateString => "${publishedAt.day}.${publishedAt.month}.${publishedAt.year}";
}

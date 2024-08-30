enum BlogCategory { Technology, Lifestyle, Education, Entertainment }

class Blog {
  int id;
  String title;
  String content;
  DateTime publishedAt;
  int likes;
  BlogCategory category;
  String? imagePath;

  bool isLikedByMe = false;

  Blog({
    this.id = 0,
    required this.title,
    required this.content,
    required this.publishedAt,
    required this.likes,
    required this.category,
    this.imagePath,
  });

  String get publishedDateString => "${publishedAt.day}.${publishedAt.month}.${publishedAt.year}";
}

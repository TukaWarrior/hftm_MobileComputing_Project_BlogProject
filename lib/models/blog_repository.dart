import 'package:blog_project/models/blog_post.dart'; // Import BlogPost

abstract class BlogRepository {
  Future<List<BlogPost>> getBlogs(); // Get all blog posts
  Future<void> addBlog(BlogPost blogPost); // Add a new blog post
}

class InMemoryBlogRepository extends BlogRepository {
  final List<BlogPost> _blogs = [
    BlogPost("First Title", "First Message", "2024.05.27"),
    BlogPost("Second Title", "Second Message", "2024.05.27"),
    BlogPost("Third Title", "Third Message", "2024.05.27"),
  ];

  @override
  Future<List<BlogPost>> getBlogs() async {
    return Future.value(_blogs); // Return a copy of the list
  }

  @override
  Future<void> addBlog(BlogPost blogPost) async {
    _blogs.add(blogPost);
  }
}

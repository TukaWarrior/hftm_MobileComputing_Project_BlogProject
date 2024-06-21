import 'dart:async';

import 'package:blog_project/models/blog.dart';

class BlogRepository {
  // Static instance + private Constructor for simple Singleton-approach
  static BlogRepository instance = BlogRepository._privateConstructor();
  BlogRepository._privateConstructor();

  final _blogs = <Blog>[];
  int _nextId = 1;
  bool _isInitialized = false;

  void _initializeBlogs() async {
    addBlogPost(Blog(
      title: "Blog Title 1",
      content: "Blog Title 1",
      publishedAt: DateTime.now(),
    ));

    addBlogPost(Blog(
      title: "Blog Title 2",
      content: "Blog Title 2",
      publishedAt: DateTime.now().subtract(const Duration(days: 1)),
    ));

    addBlogPost(Blog(
      title: "Blog Title 3",
      content: "Blog Title 3",
      publishedAt: DateTime.now().subtract(const Duration(days: 2)),
    ));

    _isInitialized = true;
  }

  /// Returns all blog posts ordered by publishedAt descending.
  /// Simulates network delay.
  Future<List<Blog>> getBlogPosts() async {
    if (!_isInitialized) {
      _initializeBlogs();
    }
    await Future.delayed(const Duration(milliseconds: 500));
    return _blogs..sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
  }

  /// Creates a new blog post and sets a new id.
  Future<void> addBlogPost(Blog blog) async {
    blog.id = _nextId++;
    _blogs.add(blog);
  }

  /// Deletes a blog post.
  Future<void> deleteBlogPost(Blog blog) async {
    _blogs.remove(blog);
  }

  /// Changes the like info of a blog post.
  Future<void> toggleLikeInfo(int blogId) async {
    final blog = _blogs.firstWhere((blog) => blog.id == blogId);
    blog.isLikedByMe = !blog.isLikedByMe;
  }

  /// Updates a blog post with the given id.
  Future<void> updateBlogPost({required int blogId, required String title, required String content}) async {
    final blog = _blogs.firstWhere((blog) => blog.id == blogId);
    blog.title = title;
    blog.content = content;
  }
}


// import 'package:blog_project/models/blog_post.dart'; // Import BlogPost

// abstract class BlogRepository {
//   Future<List<BlogPost>> getBlogs(); // Get all blog posts
//   Future<void> addBlog(BlogPost blogPost); // Add a new blog post
// }

// class InMemoryBlogRepository extends BlogRepository {
//   final List<BlogPost> _blogs = [
//     BlogPost("First Title", "First Message", "2024.05.27"),
//     BlogPost("Second Title", "Second Message", "2024.05.27"),
//     BlogPost("Third Title", "Third Message", "2024.05.27"),
//   ];

//   @override
//   Future<List<BlogPost>> getBlogs() async {
//     return Future.value(_blogs); // Return a copy of the list
//   }

//   @override
//   Future<void> addBlog(BlogPost blogPost) async {
//     _blogs.add(blogPost);
//   }
// }

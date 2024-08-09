import 'dart:async';

import 'package:blog_project/services/blogApi.dart';
import 'package:flutter/material.dart';
import 'package:blog_project/models/blog.dart';

class BlogProvider extends ChangeNotifier {
  bool isLoading = false;
  List<Blog> _blogs = [];

  List<Blog> get blogs => _blogs;

  BlogProvider() {
    _startRefreshTimer();
    readBlogsWithLoadingState();
  }

  /// Refresh every Minute
  void _startRefreshTimer() {
    Timer.periodic(const Duration(minutes: 1), (timer) {
      readBlogs();
    });
  }

  Future<void> readBlogsWithLoadingState() async {
    isLoading = true;
    notifyListeners();

    await readBlogs(withNotifying: false);

    isLoading = false;
    notifyListeners();
  }

  Future<void> readBlogs({bool withNotifying = true}) async {
    try {
      _blogs = await BlogApi.instance.getBlogs(); // Fetch blogs from backend
      if (withNotifying) {
        notifyListeners();
      }
    } catch (e) {
      // Handle the error as needed, e.g., log it, show a message, etc.
      if (withNotifying) {
        notifyListeners();
      }
    }
  }

  Future<void> deleteBlog(int blogId) async {
    try {
      await BlogApi.instance.deleteBlog(blogId: blogId.toString());
      await readBlogsWithLoadingState(); // Refresh the blog list after deletion
    } catch (e) {
      // Handle the error as needed
    }
  }

  Future<void> updateBlog(Blog blog) async {
    try {
      await BlogApi.instance.patchBlog(
        blogId: blog.id.toString(),
        title: blog.title,
        content: blog.content,
      );
      await readBlogsWithLoadingState(); // Refresh the blog list after update
    } catch (e) {
      // Handle the error as needed
    }
  }

  Future<void> toggleLikeInfo(int blogId) async {
    try {
      // Assuming the toggle like is part of the update (patch) operation
      await BlogApi.instance.patchBlog(
        blogId: blogId.toString(),
        // You may want to include additional parameters for like/unlike functionality
      );
      await readBlogsWithLoadingState(); // Refresh the blog list after liking/unliking
    } catch (e) {
      // Handle the error as needed
    }
  }
}

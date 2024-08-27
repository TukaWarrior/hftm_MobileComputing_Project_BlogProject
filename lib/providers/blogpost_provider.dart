import 'dart:async';

import 'package:flutter_blog/models/blogpost.dart';
import 'package:flutter_blog/services/blogpost_service.dart';
import 'package:flutter/material.dart';

class BlogPostProvider extends ChangeNotifier {
  bool isLoading = false;
  List<BlogPost> _blogpost = [];
  List<BlogPost> get blogposts => _blogpost;
  final BlogPostService _blogService = BlogPostService(); // Create an instance of BlogService

  BlogPostProvider() {
    _startRefreshTimer();
    readBlogsWithLoadingState();
  }

  /// Refresh every Minute
  void _startRefreshTimer() {
    Timer.periodic(const Duration(seconds: 10), (timer) {
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
    _blogpost = await _blogService.fetchBlogs() ?? [];
    if (withNotifying) {
      notifyListeners();
    }
  }
}

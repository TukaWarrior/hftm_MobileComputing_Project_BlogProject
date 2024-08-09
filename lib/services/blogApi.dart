import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/blog.dart';

class BlogApi {
  // Static instance + private Constructor for simple Singleton-approach
  static BlogApi instance = BlogApi._privateConstructor();
  BlogApi._privateConstructor();

  static const String _baseUrl = "10.0.2.2:8080";
  static const String _blogsPath = "blogs";

  Future<List<Blog>> getBlogs() async {
    try {
      final response = await http.get(
        Uri.http(_baseUrl, _blogsPath),
      );
      if (response.statusCode == 200) {
        final List<dynamic> blogsJson = jsonDecode(response.body);
        var blogs = blogsJson.map((json) => Blog.fromJson(json)).toList();
        return blogs;
      } else {
        throw Exception('Failed to load blogs. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load blogs');
    }
  }

  Future<Blog> getBlog({required String blogId}) async {
    try {
      final response = await http.get(
        Uri.http(_baseUrl, "$_blogsPath/$blogId"),
      );
      if (response.statusCode == 200) {
        final Map<String, dynamic> blogJson = jsonDecode(response.body);
        return Blog.fromJson(blogJson);
      } else {
        throw Exception('Failed to load blog. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to load blog');
    }
  }

  Future<void> addBlog({required String title, required String content, required DateTime publishedAt}) async {
    try {
      final response = await http.post(
        Uri.http(_baseUrl, _blogsPath),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "title": title,
          "content": content,
          "publishedAt": publishedAt.toIso8601String(),
        }),
      );
      if (response.statusCode != 201) {
        throw Exception('Failed to create blog. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to create blog');
    }
  }

  Future<void> patchBlog({required String blogId, String? title, String? content}) async {
    var patchBody = {
      if (title != null) "title": title,
      if (content != null) "content": content,
    };
    try {
      final response = await http.patch(
        Uri.http(_baseUrl, "$_blogsPath/$blogId"),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(patchBody),
      );
      if (response.statusCode != 200) {
        throw Exception('Failed to update blog. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to update blog');
    }
  }

  Future<void> deleteBlog({required String blogId}) async {
    try {
      final response = await http.delete(
        Uri.http(_baseUrl, "$_blogsPath/$blogId"),
      );
      if (response.statusCode != 204) {
        throw Exception('Failed to delete blog. Status code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to delete blog');
    }
  }
}

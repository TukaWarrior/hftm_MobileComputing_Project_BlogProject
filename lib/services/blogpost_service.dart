import 'dart:convert';
import 'package:flutter_blog/models/blogpost.dart';
import 'package:http/http.dart' as http;

class BlogPostService {
  final String baseUrlWindows = 'http://localhost:8080/blogs'; // When run in Windows Emulator
  final String baseUrlAndroid = 'http://10.0.2.2:8080/blogs'; // When run in Android Emulator
  final String baseUrlLocalPC = 'http://192.168.1.201:8080/blogs'; // When run on Smartphone. Local IP of host device.

  Future<List<BlogPost>?> fetchBlogs() async {
    try {
      final response = await http.get(Uri.parse(baseUrlLocalPC));

      if (response.statusCode == 200) {
        List<dynamic> body = json.decode(response.body);
        List<BlogPost> blogPosts = body.map((dynamic item) => BlogPost.fromJson(item)).toList();
        return blogPosts;
      } else {
        // You can log the error or handle it accordingly
        print('Failed to load blogs: ${response.statusCode}');
        return null; // Return null or an empty list
      }
    } catch (e) {
      // Handle the exception by logging it or showing an error message
      print('Exception caught: $e');
      return null; // Return null or an empty list
    }
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_blog/models/blogpost.dart';
import 'package:flutter_blog/screens/blogpost/blogpost_item.dart';
import 'package:flutter_blog/screens/shared/error.dart';
import 'package:flutter_blog/screens/shared/loading.dart';
import 'package:flutter_blog/screens/shared/navigation_bar.dart';
import 'package:flutter_blog/services/firestore.dart';

class BlogPostScreen extends StatelessWidget {
  const BlogPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<BlogPost>>(
        future: FirestoreService().getAllBlogPosts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingScreen();
          } else if (snapshot.hasError) {
            return Center(
              child: ErrorMessage(message: snapshot.error.toString()),
            );
          } else if (snapshot.hasData) {
            var blogposts = snapshot.data!;

            return Scaffold(
              appBar: AppBar(
                title: const Text('Blogposts'),
              ),
              body: ListView(
                children: blogposts
                    .map((blogpost) => BlogPostItem(
                          blogpost: blogpost,
                        ))
                    .toList(),
              ),
              bottomNavigationBar: const NavBar(),
            );
          } else {
            return const Text('No blog posts found in Firestore.');
          }
        });
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_blog/models/blogpost.dart';
import 'package:flutter_blog/screens/blogpost/blogpost.dart';
import 'package:flutter_blog/screens/blogpost/blogpost_detail.dart';

class BlogPostItem extends StatelessWidget {
  final BlogPost blogpost;

  const BlogPostItem({super.key, required this.blogpost});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          // Uncomment and update this when the BlogPostScreen (detail view) is ready
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (BuildContext context) => BlogPostDetailScreen(blogpost: blogpost),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (blogpost.imageURL.isNotEmpty)
              Image.network(
                blogpost.imageURL,
                height: 200, // Fixed height for a better layout
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                blogpost.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

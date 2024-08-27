import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_project/models/blog.dart';
import 'package:blog_project/providers/blog_provider.dart';

class BlogDetailPage extends StatelessWidget {
  final Blog blog;

  const BlogDetailPage.BlogDetailScreen({required this.blog, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Blog Details'),
      // ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (blog.imagePath != null)
              Image.asset(
                blog.imagePath!,
                height: 400.0,
                fit: BoxFit.cover,
              ), // Display the image if it exists
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and likes counter
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          blog.title,
                          style: Theme.of(context).textTheme.displayLarge,
                        ),
                      ),
                      Row(
                        children: [
                          const Icon(Icons.favorite, color: Colors.red),
                          const SizedBox(width: 4),
                          Text(
                            blog.likes.toString(),
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0),
                  // Creator's avatar, name, and date
                  Divider(
                    thickness: 1.0,
                    color: Color(0xFF6a6977),
                    height: 32.0,
                  ),
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 32.0,
                        backgroundImage: AssetImage(
                          'assets/images/exampleavatar01.webp',
                        ), // Replace with the actual avatar image
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Peter Parker", // Replace with the actual creator's name
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const Spacer(),
                      Text(
                        blog.publishedDateString,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  Divider(
                    thickness: 1.0,
                    color: Color(0xFF6a6977),
                    height: 32.0,
                  ),
                  Text(
                    blog.content,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Container(
                    height: 64.0,
                    margin: EdgeInsets.only(top: 16.0),
                    decoration: BoxDecoration(
                      color: Color(0xFF6a6977),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Write a comment...",
                        hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_blog/models/blogpost.dart';

class BlogPostDetailScreen extends StatelessWidget {
  final BlogPost blogpost;

  const BlogPostDetailScreen({super.key, required this.blogpost});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        Hero(
          tag: blogpost.imageURL, // This is not working
          child: Image.network(
            blogpost.imageURL,
            // height: 200, // Fixed height for a better layout
            // fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        Text(
          blogpost.title,
          style: const TextStyle(height: 2, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const Divider(
          thickness: 1.0,
          color: Color(0xFF6a6977),
          height: 32.0,
        ),
        Row(
          children: [
            const CircleAvatar(
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
              blogpost.publishedDate.toString(),
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
        const Divider(
          thickness: 1.0,
          color: Color(0xFF6a6977),
          height: 32.0,
        ),
      ]),
    );
  }
}

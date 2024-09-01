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
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blogpost.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    blogpost.publishedDate.toString().substring(0, 10),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    blogpost.category,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                ],
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
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  const Spacer(),
                ],
              ),
              const Divider(
                thickness: 1.0,
                color: Color(0xFF6a6977),
                height: 32.0,
              ),
              Text(
                blogpost.content,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              // Container(
              //   height: 64.0,
              //   margin: const EdgeInsets.only(top: 16.0),
              //   decoration: BoxDecoration(
              //     color: const Color(0xFF6a6977),
              //     borderRadius: BorderRadius.circular(12.0),
              //   ),
              //   child: const TextField(
              //     decoration: InputDecoration(
              //       border: InputBorder.none,
              //       hintText: "Write a comment...",
              //       hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
              //     ),
              //   ),
              // )
            ],
          ),
        )
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_blog/models/blogpost.dart';
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
                height: 200,
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blogpost.title,
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        blogpost.category,
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      Text(
                        blogpost.publishedDate.toString().substring(0, 10),
                        style: Theme.of(context).textTheme.labelLarge,
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

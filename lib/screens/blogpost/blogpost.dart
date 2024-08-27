import 'package:flutter_blog/providers/blogpost_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_blog/models/blogpost.dart';

class BlogPostScreen extends StatelessWidget {
  const BlogPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BlogPosts"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await context.read<BlogPostProvider>().readBlogsWithLoadingState();
        },
        child: const BlogListWidget(),
      ),
    );
  }
}

class BlogListWidget extends StatelessWidget {
  const BlogListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final blogpostProvider = context.watch<BlogPostProvider>();

    if (blogpostProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (blogpostProvider.blogposts.isEmpty) {
      return const Center(child: Text('No blogs yet.'));
    }

    return ListView.builder(
      itemCount: blogpostProvider.blogposts.length,
      itemBuilder: (context, index) {
        final blog = blogpostProvider.blogposts[index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlogWidget(blogpost: blog),
        );
      },
    );
  }
}

class BlogWidget extends StatelessWidget {
  const BlogWidget({super.key, required this.blogpost});

  final BlogPost blogpost;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Uncomment and implement if you want to navigate to a detailed blog page.
        // Navigator.of(context).push(MaterialPageRoute(
        // builder: (context) => BlogDetailPage(blog: blogpost),
        // ));
      },
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blogpost.title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              const SizedBox(height: 8.0),
              Text(blogpost.content),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    blogpost.publishedDateString,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontStyle: FontStyle.italic,
                        ),
                  ),
                  IconButton(
                    icon: Icon(
                      blogpost.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                    ),
                    onPressed: () {
                      // Implement like functionality if necessary
                      // Example:
                      // await blogpostProvider.toggleLike(blogpost.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

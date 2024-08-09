import 'package:blog_project/providers/blogpost_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_project/services/blogpost_api.dart';
import 'package:blog_project/models/blogpost.dart';

class BlogPostPage extends StatelessWidget {
  const BlogPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BlogPosts"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BlogPostProvider>().readBlogsWithLoadingState();
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
    BlogPostProvider blogpostProvider = context.watch<BlogPostProvider>();

    return Stack(children: [
      blogpostProvider.blogs.isEmpty && !blogpostProvider.isLoading
          ? const Center(
              child: Text('No blogs yet.'),
            )
          : ListView.builder(
              itemCount: blogpostProvider.blogs.length,
              itemBuilder: (context, index) {
                var blog = blogpostProvider.blogs[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: BlogWidget(blogpost: blog),
                );
              },
            ),
      if (blogpostProvider.isLoading)
        const Center(
          child: CircularProgressIndicator(),
        )
    ]);
  }
}

class BlogWidget extends StatelessWidget {
  const BlogWidget({super.key, required this.blogpost});

  final BlogPost blogpost;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          // Navigator.of(context).push(MaterialPageRoute(
          // builder: (context) => BlogDetailPage(blog: blogpost),
          // ));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
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
                    Text(blogpost.publishedDateString,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontStyle: FontStyle.italic,
                            )),
                    IconButton(
                      icon: Icon(
                        blogpost.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                      ),
                      onPressed: () async {
                        // var blogProvider = context.read<BlogProvider>();
                        // await BlogRepository.instance.toggleLikeInfo(blogpost.id);
                        // blogProvider.readBlogsWithLoadingState();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

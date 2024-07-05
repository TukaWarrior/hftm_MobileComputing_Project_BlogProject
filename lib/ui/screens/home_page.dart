import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_project/models/blog.dart';
import 'package:blog_project/providers/blog_provider.dart';
import 'package:blog_project/ui/screens/blog/blog_detail_page.dart';
import 'package:blog_project/services/blog_repository.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Blog"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          context.read<BlogProvider>().readBlogsWithLoadingState();
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
    BlogProvider blogProvider = context.watch<BlogProvider>();

    return Stack(children: [
      blogProvider.blogs.isEmpty && !blogProvider.isLoading
          ? const Center(
              child: Text('No blogs yet.'),
            )
          : ListView.builder(
              itemCount: blogProvider.blogs.length,
              itemBuilder: (context, index) {
                var blog = blogProvider.blogs[index];
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: BlogWidget(blog: blog),
                );
              },
            ),
      if (blogProvider.isLoading)
        const Center(
          child: CircularProgressIndicator(),
        )
    ]);
  }
}

class BlogWidget extends StatelessWidget {
  const BlogWidget({super.key, required this.blog});

  final Blog blog;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => BlogDetailPage(blog: blog),
          ));
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  blog.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                const SizedBox(height: 8.0),
                Text(blog.content),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(blog.publishedDateString,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              fontStyle: FontStyle.italic,
                            )),
                    IconButton(
                      icon: Icon(
                        blog.isLikedByMe ? Icons.favorite : Icons.favorite_border,
                      ),
                      onPressed: () async {
                        var blogProvider = context.read<BlogProvider>();
                        await BlogRepository.instance.toggleLikeInfo(blog.id);
                        blogProvider.readBlogsWithLoadingState();
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

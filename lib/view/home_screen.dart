import 'package:blog_project/models/blog_post.dart'; // Import BlogPost
import 'package:blog_project/models/blog_repository.dart';
import 'package:blog_project/view/editor.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});
  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final BlogRepository _blogRepository = InMemoryBlogRepository();
  // var blogs = [
  //   BlogPost("First Title", "First Message", "2024.05.27"),
  //   BlogPost("Second Title", "Second Message", "2024.05.27"),
  //   BlogPost("Third Title", "Third Message", "2024.05.27"),
  // ];

  void _addBlog() async {
    // ... navigate to EditorView and get result
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const EditorView()),
    );

    if (result is BlogPost) {
      await _blogRepository.addBlog(result); // Add post using repository
      setState(() {
        // No need to update blogs list as _blogRepository manages it
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: FutureBuilder<List<BlogPost>>(
        future: _blogRepository.getBlogs(), // Fetch blogs from repository
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final blogs = snapshot.data!;
            return ListView.builder(
              itemCount: blogs.length,
              itemBuilder: (context, index) {
                return BlogCard(blog: blogs[index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addBlog,
        tooltip: 'Add a blog',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class BlogCard extends StatelessWidget {
  const BlogCard({
    super.key,
    required this.blog,
  });
  final BlogPost blog;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              blog.title,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            const SizedBox(
              height: 8,
            ),
            Text(blog.text),
            const SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(blog.date),
                const Icon(Icons.favorite_outline),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

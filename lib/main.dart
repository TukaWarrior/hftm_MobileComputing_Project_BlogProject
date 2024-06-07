import 'package:blog_project/models/blog_post.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Blog Project',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Blog Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var blogs = [
    BlogPost("First Title", "First Message", "2024.05.27"),
    BlogPost("Second Title", "Second Message", "2024.05.27"),
    BlogPost("Third Title", "Third Message", "2024.05.27")
  ];

  void _addBlog() {
    setState(() {
      blogs.add(BlogPost("titel", "text", "date"));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: blogs.length,
        itemBuilder: (context, index) {
          return BlogCard(blog: blogs[index]);
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
            )
          ],
        ),
      ),
    );
  }
}

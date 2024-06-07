import 'package:flutter/material.dart';
import 'package:blog_project/models/blog_post.dart'; // Import BlogPost

class EditorView extends StatefulWidget {
  const EditorView({super.key});

  @override
  State<EditorView> createState() => _EditorViewState();
}

class _EditorViewState extends State<EditorView> {
  final titleController = TextEditingController();
  final textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog Editor'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TextField(
                controller: textController,
                maxLines: null, // Allow multiple lines for the body text
                decoration: const InputDecoration(
                  labelText: 'Body',
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Create a new BlogPost object and navigate back
                String title = titleController.text;
                String text = textController.text;
                String date = DateTime.now()
                    .toString()
                    .split(' ')
                    .first; // Extract current date
                BlogPost newPost = BlogPost(title, text, date);
                Navigator.pop(context, newPost); // Pass created BlogPost back
              },
              child: const Text('Create Post'),
            ),
          ],
        ),
      ),
    );
  }
}

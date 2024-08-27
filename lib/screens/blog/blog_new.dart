import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blog_project/models/blog.dart';
import 'package:blog_project/providers/blog_provider.dart';
import 'package:blog_project/services/blog_repository.dart';
import 'package:image_picker/image_picker.dart';

class BlogNewScreen extends StatefulWidget {
  const BlogNewScreen({super.key});

  @override
  State<BlogNewScreen> createState() => _BlogNewScreenState();
}

enum _PageStates { loading, editing, done }

class _BlogNewScreenState extends State<BlogNewScreen> {
  final formKey = GlobalKey<FormState>();
  var pageState = _PageStates.editing;
  var title = "";
  var content = "";
  String? imagePath; // Add this variable to store the selected image path

  final ImagePicker _picker = ImagePicker(); // ImagePicker instance

  Future<void> _pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera); // Capture image from camera
    if (image != null) {
      setState(() {
        imagePath = image.path; // Set the image path
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Blog"),
      ),
      body: Builder(builder: (context) {
        switch (pageState) {
          case _PageStates.loading:
            return const Center(child: CircularProgressIndicator());
          case _PageStates.done:
            return Center(child: Text("Blog '$title' created!"));
          case _PageStates.editing:
            return Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: [
                    const SizedBox(height: 20),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: "Title",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 4) {
                          return "Please enter title with 4 or more characters";
                        }
                        return null;
                      },
                      onSaved: (value) => title = value!,
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      maxLines: 10,
                      decoration: const InputDecoration(
                        labelText: "Content",
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.length < 10) {
                          return "Please enter content with 10 or more characters";
                        }
                        return null;
                      },
                      onSaved: (value) => content = value!,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _pickImage, // Button to capture image
                      child: const Text("Capture Image"),
                    ),
                    if (imagePath != null)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Image.file(File(imagePath!)), // Display the captured image
                      ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        // Hide keyboard
                        FocusScope.of(context).unfocus();

                        if (formKey.currentState!.validate()) {
                          setState(() {
                            pageState = _PageStates.loading;
                          });
                          formKey.currentState!.save();
                          await _createBlog();
                          setState(() {
                            pageState = _PageStates.done;
                          });
                        }
                      },
                      child: const Text("Save"),
                    ),
                    const SizedBox(height: 8.0),
                  ],
                ),
              ),
            );
        }
      }),
    );
  }

  Future<void> _createBlog() async {
    var blogProvider = context.read<BlogProvider>();
    await Future.delayed(const Duration(seconds: 1));
    await BlogRepository.instance.addBlogPost(Blog(
      title: title,
      content: content,
      publishedAt: DateTime.now(),
      category: BlogCategory.Technology,
      likes: 42,
      imagePath: imagePath, // Save the image path
    ));
    blogProvider.readBlogs();
  }
}

class BlogForm extends StatefulWidget {
  const BlogForm({super.key});

  @override
  State<BlogForm> createState() => _BlogFormState();
}

class _BlogFormState extends State<BlogForm> {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

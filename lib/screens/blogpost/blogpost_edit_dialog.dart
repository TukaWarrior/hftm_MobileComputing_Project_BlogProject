import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_blog/models/blogpost.dart';
import 'package:flutter_blog/services/firestore.dart';

class BlogPostEditDialog extends StatefulWidget {
  final BlogPost blogpost;

  const BlogPostEditDialog({super.key, required this.blogpost});

  @override
  _BlogPostEditDialogState createState() => _BlogPostEditDialogState();
}

class _BlogPostEditDialogState extends State<BlogPostEditDialog> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  String? _selectedCategory;
  File? _image;

  final picker = ImagePicker();
  final FirestoreService firestoreService = FirestoreService();

  @override
  void initState() {
    super.initState();
    _title = widget.blogpost.title;
    _content = widget.blogpost.content;
    _selectedCategory = widget.blogpost.category;
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  Future<void> _saveChanges() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      String imageUrl = widget.blogpost.imageURL; // Default to existing image URL

      try {
        // If a new image is selected, delete the old one and upload the new one
        if (_image != null) {
          // Delete old image
          if (imageUrl.isNotEmpty) {
            await firestoreService.deleteImageFromStorage(imageUrl);
          }

          // Upload new image and get the URL
          imageUrl = await firestoreService.uploadImage(
            _image!,
            'blogpost_images',
          );
        }

        // Create an updated blog post instance
        BlogPost updatedPost = BlogPost(
          documentID: widget.blogpost.documentID, // Use existing document ID
          title: _title,
          content: _content,
          category: _selectedCategory ?? '',
          publishedDate: widget.blogpost.publishedDate,
          imageURL: imageUrl,
          userUID: widget.blogpost.userUID,
        );

        // Update the blog post in Firestore
        await firestoreService.updateBlogPost(updatedPost);

        Navigator.of(context).pop(); // Close the dialog
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Blog post updated successfully!')),
        );
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update blog post: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Edit Blog Post'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                onSaved: (value) => _title = value ?? '',
                validator: (value) => value!.isEmpty ? 'Title cannot be empty' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                initialValue: _content,
                decoration: const InputDecoration(labelText: 'Content'),
                onSaved: (value) => _content = value ?? '',
                validator: (value) => value!.isEmpty ? 'Content cannot be empty' : null,
              ),
              const SizedBox(height: 20),

              // Buttons for image selection
              Column(
                children: [
                  ElevatedButton(
                    onPressed: _getImageFromGallery,
                    child: const Text('Change Image from Gallery'),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _getImageFromCamera,
                    child: const Text('Change Image from Camera'),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: _saveChanges,
                child: const Text('Save Changes'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

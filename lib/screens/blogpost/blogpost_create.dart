import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_blog/models/blogpost.dart';
import 'package:flutter_blog/models/category.dart'; // Import the Category model
import 'package:flutter_blog/services/firestore.dart';

class BlogPostCreateScreen extends StatefulWidget {
  @override
  _BlogPostCreateScreenState createState() => _BlogPostCreateScreenState();
}

class _BlogPostCreateScreenState extends State<BlogPostCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  String _category = '';
  File? _image;

  final picker = ImagePicker();
  final FirestoreService firestoreService = FirestoreService();

  List<Category> _categories = []; // List to store fetched categories
  String? _selectedCategory; // Store selected category with emoji

  @override
  void initState() {
    super.initState();
    _fetchCategories(); // Fetch categories on initialization
  }

  Future<void> _fetchCategories() async {
    try {
      List<Category> categories = await firestoreService.getAllCategories();
      setState(() {
        _categories = categories;
      });
    } catch (e) {
      print('Error fetching categories: $e');
    }
  }

  Future<void> _getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _saveBlogPost() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final userUID = FirebaseAuth.instance.currentUser?.uid ?? '';
      // Upload the image to Firebase Storage first
      String imageUrl = _image == null ? '' : await firestoreService.uploadImage(_image!, 'blogpost_images');
      // Create a new blog post instance
      BlogPost newPost = BlogPost(
        title: _title,
        content: _content,
        category: _selectedCategory ?? '', // Use the combined emoji + name string
        publishedDate: DateTime.now(),
        imageURL: imageUrl,
        userUID: userUID,
      );
      // Save the blog post to Firestore
      await firestoreService.addBlogPost(newPost);
      Navigator.of(context).pop(); // Optionally pop back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Blog Post"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: EdgeInsets.all(8.0),
          children: <Widget>[
            TextFormField(
              decoration: InputDecoration(labelText: 'Title'),
              onSaved: (value) => _title = value ?? '',
              validator: (value) => value!.isEmpty ? 'Title cannot be empty' : null,
            ),
            TextFormField(
              decoration: InputDecoration(labelText: 'Content'),
              onSaved: (value) => _content = value ?? '',
              validator: (value) => value!.isEmpty ? 'Content cannot be empty' : null,
            ),
            SizedBox(height: 10),
            _categories.isEmpty
                ? CircularProgressIndicator() // Show loading indicator if categories are being fetched
                : DropdownButtonFormField<String>(
                    decoration: InputDecoration(labelText: 'Category'),
                    value: _selectedCategory,
                    items: _categories.map((Category category) {
                      // Combine emoji and name in the dropdown menu items
                      String displayValue = '${category.emoji} ${category.name}';
                      return DropdownMenuItem<String>(
                        value: displayValue, // Use combined string as value
                        child: Text(displayValue),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        _selectedCategory = value; // Store combined emoji + name string
                      });
                    },
                    validator: (value) => value == null || value.isEmpty ? 'Please select a category' : null,
                  ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _getImageFromCamera,
              child: Text('Select Image from Camera'),
            ),
            ElevatedButton(
              onPressed: _getImageFromGallery,
              child: Text('Select Image from Gallery'),
            ),
            if (_image != null) Image.file(_image!),
            ElevatedButton(
              onPressed: _saveBlogPost,
              child: Text('Submit Blog Post'),
            ),
          ],
        ),
      ),
    );
  }
}

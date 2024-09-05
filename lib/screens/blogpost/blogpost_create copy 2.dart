import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/screens/shared/navigation_bar.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_blog/models/blogpost.dart';
import 'package:flutter_blog/models/category.dart'; // Import the Category model
import 'package:flutter_blog/services/firestore.dart';

class BlogPostCreateScreen extends StatefulWidget {
  const BlogPostCreateScreen({super.key});

  @override
  _BlogPostCreateScreenState createState() => _BlogPostCreateScreenState();
}

class _BlogPostCreateScreenState extends State<BlogPostCreateScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  final String _category = '';
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
      // Navigator.of(context).pop(); // Optionally pop back to the previous screen
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Blog Post"),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: const NavBar(),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0), // Consistent padding for the ListView
          children: <Widget>[
            // Image preview card
            GestureDetector(
              onTap: _getImageFromGallery, // Tap to pick image
              child: Container(
                height: 240,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: _image != null
                    ? ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.file(
                          _image!,
                          fit: BoxFit.cover,
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.add_a_photo,
                            color: Colors.black45,
                          ),
                          SizedBox(height: 8),
                          Text('Add an image'),
                        ],
                      ),
              ),
            ),
            const SizedBox(height: 10),
            // Buttons for image selection
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _getImageFromCamera,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[400], // Grey color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                    ),
                    child: const Text('Camera'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _getImageFromGallery,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[400], // Grey color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8), // Rounded corners
                      ),
                    ),
                    child: const Text('Gallery'),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            // Form fields for title, content, and category selection
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              onSaved: (value) => _title = value ?? '',
              validator: (value) => value!.isEmpty ? 'Title cannot be empty' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Content'),
              onSaved: (value) => _content = value ?? '',
              validator: (value) => value!.isEmpty ? 'Content cannot be empty' : null,
            ),
            const SizedBox(height: 10),
            _categories.isEmpty
                ? const CircularProgressIndicator() // Show loading indicator if categories are being fetched
                : DropdownButtonFormField<String>(
                    decoration: const InputDecoration(labelText: 'Category'),
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
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveBlogPost,
              child: const Text('Submit Blog Post'),
            ),
          ],
        ),
      ),
    );
  }
}

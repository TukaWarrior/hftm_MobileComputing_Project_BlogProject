import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:flutter_blog/models/blogpost.dart';
import 'package:flutter_blog/services/firestore.dart';

class BlogNewScreen extends StatefulWidget {
  @override
  _BlogNewScreenState createState() => _BlogNewScreenState();
}

class _BlogNewScreenState extends State<BlogNewScreen> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _content = '';
  String _category = '';
  File? _image;

  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

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
      FirestoreService firestoreService = FirestoreService();
      String imageUrl = _image == null ? '' : await firestoreService.uploadImage(_image!, 'blogpost_images');
      // Create a new blog post instance
      BlogPost newPost = BlogPost(
        title: _title,
        content: _content,
        category: _category,
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
            TextFormField(
              decoration: InputDecoration(labelText: 'Category'),
              onSaved: (value) => _category = value ?? '',
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: getImage,
              child: Text('Select Image'),
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

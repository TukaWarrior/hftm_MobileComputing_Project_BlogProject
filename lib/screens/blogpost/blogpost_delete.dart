import 'dart:ui'; // For BackdropFilter
import 'package:flutter/material.dart';
import 'package:flutter_blog/models/blogpost.dart';
import 'package:flutter_blog/services/firestore.dart';

class BlogPostDelete {
  static Future<void> showDeleteDialog(BuildContext context, BlogPost blogpost) async {
    final shouldDelete = await showDialog<bool>(
      context: context,
      barrierDismissible: false, // Prevent dismissal by tapping outside
      builder: (context) => BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5), // Apply blur effect
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Adjust this value for less rounded corners
          ),
          // backgroundColor: Colors.grey[200], // Set the color to a grey shade
          title: const Text('Delete Blog Post'),
          content: const Text('Are you sure you want to delete this blog post?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false), // Cancel delete
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true), // Confirm delete
              child: const Text('Delete'),
            ),
          ],
        ),
      ),
    );

    if (shouldDelete == true) {
      await _deleteBlogPost(context, blogpost);
    }
  }

  // Delete blog post function
  static Future<void> _deleteBlogPost(BuildContext context, BlogPost blogpost) async {
    try {
      if (blogpost.imageURL.isNotEmpty) {
        await FirestoreService().deleteImageFromStorage(blogpost.imageURL);
      }

      await FirestoreService().deleteBlogPost(blogpost.documentID);
      Navigator.of(context).pop(); // Go back after deletion
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Blog post deleted successfully!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete blog post: $e')),
      );
    }
  }
}

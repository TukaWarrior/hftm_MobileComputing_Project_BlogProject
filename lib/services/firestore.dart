import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_blog/models/blogpost.dart';
import 'package:flutter_blog/models/category.dart';
import 'package:flutter_blog/models/profile.dart';
import 'package:flutter_blog/services/auth.dart';

// firestore.dart handles the data fetching from the firestore database.

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ------------------ Blog Posts ------------------
  Future<List<BlogPost>> getAllBlogPosts() async {
    try {
      var ref = _db.collection('blogposts');
      var snapshot = await ref.get();
      if (snapshot.docs.isEmpty) {
        return [];
      }
      // var data = snapshot.docs.map((s) => s.data());
      // var blogposts = data.map((d) => BlogPost.fromJson(d));
      // return blogposts.toList();
      return snapshot.docs.map((doc) => BlogPost.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw Exception('An error occurred during the Firebase operation: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch blog posts: $e');
    }
  }

  Future<BlogPost?> getBlogPost(String blogpostId) async {
    try {
      var ref = _db.collection('blogposts').doc(blogpostId);
      var snapshot = await ref.get();
      if (snapshot.data() == null) {
        return null;
      }
      // return BlogPost.fromJson(snapshot.data()!);
      return BlogPost.fromDocument(snapshot);
    } on FirebaseException catch (e) {
      throw Exception('An error occurred during the Firebase operation: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch blog post: $e');
    }
  }

  Future<void> addBlogPost(BlogPost blogPost) async {
    try {
      await _db.collection('blogposts').add(blogPost.toJson());
    } on FirebaseException catch (e) {
      throw Exception('An error occurred during the Firebase operation: ${e.message}');
    } catch (e) {
      throw Exception('Failed to create blog post: $e');
    }
  }

  Future<void> deleteBlogPost(String blogpostId) async {
    try {
      var ref = _db.collection('blogposts').doc(blogpostId);
      await ref.delete();
    } on FirebaseException catch (e) {
      throw Exception('An error occurred during the Firebase operation: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete blog post: $e');
    }
  }

  // ------------------ Categories ------------------
  Future<List<Category>> getAllCategories() async {
    try {
      var ref = _db.collection('categories');
      var snapshot = await ref.get();
      if (snapshot.docs.isEmpty) {
        return [];
      }
      // var data = snapshot.docs.map((s) => s.data());
      // var categories = data.map((d) => Category.fromJson(d));
      // return categories.toList();
      return snapshot.docs.map((doc) => Category.fromDocument(doc)).toList();
    } on FirebaseException catch (e) {
      throw Exception('An error occurred during the Firebase operation: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch categories: $e');
    }
  }

  Future<Category?> getCategory(String categoryId) async {
    try {
      var ref = _db.collection('categories').doc(categoryId);
      var snapshot = await ref.get();
      if (snapshot.data() == null) {
        return null;
      }
      // return Category.fromJson(snapshot.data()!);
      return Category.fromDocument(snapshot);
    } on FirebaseException catch (e) {
      throw Exception('An error occurred during the Firebase operation: ${e.message}');
    } catch (e) {
      throw Exception('Failed to fetch category: $e');
    }
  }

  // ------------------ Image Upload (Blogpost) ------------------
  Future<String> uploadImage(File file, String path) async {
    try {
      Reference ref = _storage.ref().child('$path/${DateTime.now().toIso8601String()}');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      print('FirebaseException while uploading image: ${e.message}');
      throw Exception('An error occurred during the Firebase operation: ${e.message}');
    } catch (e) {
      print('Error while uploading image: $e');
      throw Exception('Failed to upload image: $e');
    }
  }

  Future<void> deleteImageFromStorage(String imageURL) async {
    try {
      // Create a reference to the file to delete
      final ref = _storage.refFromURL(imageURL);
      await ref.delete();
    } on FirebaseException catch (e) {
      throw Exception('An error occurred during the Firebase operation: ${e.message}');
    } catch (e) {
      throw Exception('Failed to delete image: $e');
    }
  }

  // ------------------ Avatar Image Upload ------------------
  Future<String> uploadAvatarImage(File file, String userId) async {
    try {
      // Use the user's UID as the file name
      Reference ref = _storage.ref().child('profile_avatars/$userId');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } on FirebaseException catch (e) {
      print('FirebaseException while uploading avatar image: ${e.message}');
      throw Exception('An error occurred during the Firebase operation: ${e.message}');
    } catch (e) {
      print('Error while uploading avatar image: $e');
      throw Exception('Failed to upload avatar image: $e');
    }
  }

// ------------------ User Profiles ------------------
  Future<void> createOrUpdateProfile(Profile profile) async {
    try {
      var user = AuthService().user;
      if (user != null) {
        final profileRef = _db.collection('profiles').doc(user.uid);
        await profileRef.set(profile.toJson(), SetOptions(merge: true));
      }
    } on FirebaseException catch (e) {
      print('FirebaseException while creating/updating profile: ${e.message}');
      throw Exception('An error occurred during the Firebase operation: ${e.message}');
    } catch (e) {
      print('Error while creating/updating profile: $e');
      throw Exception('Failed to create or update profile: $e');
    }
  }

  Future<Profile?> getProfile() async {
    try {
      var user = AuthService().user;
      if (user == null) {
        return null;
      }
      final userDoc = await _db.collection('profiles').doc(user.uid).get();
      if (userDoc.exists) {
        // return Profile.fromJson(userDoc.data()!);
        return Profile.fromDocument(userDoc);
      }
      return null;
    } on FirebaseException catch (e) {
      print('FirebaseException while fetching profile: ${e.message}');
      throw Exception('An error occurred during the Firebase operation: ${e.message}');
    } catch (e) {
      print('Error while fetching profile: $e');
      throw Exception('Failed to fetch profile: $e');
    }
  }

  Future<Profile?> getProfileByUID(String uid) async {
    try {
      final userDoc = await _db.collection('profiles').doc(uid).get();
      if (userDoc.exists) {
        // return Profile.fromJson(userDoc.data()!);
        return Profile.fromDocument(userDoc);
      }
      return null;
    } on FirebaseException catch (e) {
      print('FirebaseException while fetching profile by UID: ${e.message}');
      throw Exception('An error occurred during the Firebase operation: ${e.message}');
    } catch (e) {
      print('Error while fetching profile by UID: $e');
      throw Exception('Failed to fetch profile by UID: $e');
    }
  }
}

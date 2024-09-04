import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_blog/models/blogpost.dart';
import 'package:flutter_blog/models/category.dart';
import 'package:flutter_blog/models/profile.dart';
// firestore.dart handles the data fetching from the firestore database.

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // ------------------ Blog Posts ------------------
  Future<List<BlogPost>> getAllBlogPosts() async {
    var ref = _db.collection('blogposts');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var blogposts = data.map((d) => BlogPost.fromJson(d));
    return blogposts.toList();
  }

  Future<BlogPost> getBlogPost(String blogpostId) async {
    var ref = _db.collection('blogposts').doc(blogpostId);
    var snapshot = await ref.get();
    return BlogPost.fromJson(snapshot.data() ?? {});
  }

  // AI Generated
  Future<void> addBlogPost(BlogPost blogPost) async {
    await _db.collection('blogposts').add(blogPost.toJson());
  }

  // ------------------ Categories ------------------
  Future<List<Category>> getAllCategories() async {
    var ref = _db.collection('categories');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var categories = data.map((d) => Category.fromJson(d));
    return categories.toList();
  }

  Future<Category> getCategory(String categoryId) async {
    var ref = _db.collection('categories').doc(categoryId);
    var snapshot = await ref.get();
    return Category.fromJson(snapshot.data() ?? {});
  }

  // ------------------ Image Upload ------------------
  // AI Generated
  Future<String> uploadImage(File file, String path) async {
    try {
      Reference ref = _storage.ref().child('$path/${DateTime.now().toIso8601String()}');
      UploadTask uploadTask = ref.putFile(file);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print(e);
      return '';
    }
  }

// ------------------ User Profiles ------------------
  Future<void> createOrUpdateUserProfile(Profile profileData) async {
    final profile = FirebaseAuth.instance.currentUser;
    if (profile != null) {
      final profileRef = _db.collection('profiles').doc(profile.uid);
      await profileRef.set(profileData.toJson(), SetOptions(merge: true));
    }
  }

  Future<Profile> getUserProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userDoc = await _db.collection('profiles').doc(currentUser.uid).get();
      if (userDoc.exists) {
        return Profile.fromJson(userDoc.data()!);
      }
    }
    return;
  }

  Future<bool> checkUserProfileExists() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userDoc = await _db.collection('profiles').doc(currentUser.uid).get();
      return userDoc.exists;
    }
    return false;
  }
}

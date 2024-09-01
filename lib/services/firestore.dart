import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_blog/models/blogpost.dart';

// firestore.dart handles the data fetching from the firestore database.

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<BlogPost>> getBlogPosts() async {
    var ref = _db.collection('blogposts');
    var snapshot = await ref.get();
    var data = snapshot.docs.map((s) => s.data());
    var blogposts = data.map((d) => BlogPost.fromJson(d));
    return blogposts.toList();
  }

  Future<BlogPost> getBlogPostDetail(String blogpostId) async {
    var ref = _db.collection('blogposts').doc(blogpostId);
    var snapshot = await ref.get();
    return BlogPost.fromJson(snapshot.data() ?? {});
  }

  // Future<String> getDownloadURL(String filePath) async {
  //   try {
  //     Reference ref = _storage.ref().child(filePath);
  //     String url = await ref.getDownloadURL();
  //     print("Download URL: $url");
  //     return url;
  //   } catch (e) {
  //     print("Failed to get the download URL: $e");
  //     return "";
  //   }
  // }
}

import 'package:flutter/material.dart';
import 'package:flutter_blog/models/blogpost.dart';
import 'package:flutter_blog/screens/blogpost/blogpost_item.dart';
import 'package:flutter_blog/screens/shared/loading.dart';
import 'package:flutter_blog/screens/shared/navigation_bar.dart';
import 'package:flutter_blog/services/firestore.dart';

class BlogPostScreen extends StatefulWidget {
  const BlogPostScreen({super.key});

  @override
  _BlogPostScreenState createState() => _BlogPostScreenState();
}

class _BlogPostScreenState extends State<BlogPostScreen> {
  final FirestoreService _firestoreService = FirestoreService();
  final ScrollController _scrollController = ScrollController();

  List<BlogPost> _blogPosts = [];
  bool _isLoading = true;
  bool _isFetchingMore = false;
  DateTime? _lastFetchedDate;

  @override
  void initState() {
    super.initState();
    _fetchBlogPosts();
    _scrollController.addListener(_onScroll);
  }

  Future<void> _fetchBlogPosts({bool isRefresh = false}) async {
    if (isRefresh) {
      setState(() {
        _isLoading = true;
        _lastFetchedDate = null; // Reset to get the latest
      });
    }

    try {
      final newPosts = await _firestoreService.getBlogPostsByDateTime(lastDate: _lastFetchedDate);

      setState(() {
        if (isRefresh) {
          _blogPosts = newPosts; // Refresh
        } else {
          _blogPosts.addAll(newPosts); // Append new posts
        }

        if (newPosts.isNotEmpty) {
          _lastFetchedDate = newPosts.last.publishedDate;
        }

        _isLoading = false;
        _isFetchingMore = false;
      });
    } catch (error) {
      setState(() {
        _isLoading = false;
        _isFetchingMore = false;
      });
      // Handle error appropriately in production
      print('Error fetching blog posts: $error');
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >= _scrollController.position.maxScrollExtent && !_isFetchingMore) {
      setState(() {
        _isFetchingMore = true;
      });
      _fetchBlogPosts();
    }
  }

  Future<void> _onRefresh() async {
    await _fetchBlogPosts(isRefresh: true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Most recent "),
            Text(
              "Blogs",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      body: _isLoading
          ? const LoadingScreen()
          : RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: _blogPosts.length + 1,
                itemBuilder: (context, index) {
                  if (index < _blogPosts.length) {
                    return BlogPostItem(blogpost: _blogPosts[index]);
                  } else if (_isFetchingMore) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    return const SizedBox.shrink(); // Empty space at the end
                  }
                },
              ),
            ),
      bottomNavigationBar: const NavBar(),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
}

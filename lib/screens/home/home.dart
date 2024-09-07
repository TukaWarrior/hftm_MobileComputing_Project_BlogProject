import 'package:flutter/material.dart';
import 'package:flutter_blog/screens/blogpost/blogpost.dart';
import 'package:flutter_blog/screens/login/login.dart';
import 'package:flutter_blog/services/auth.dart';
import 'package:flutter_blog/providers/profile_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading...');
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else if (snapshot.hasData) {
          // Fetch and initialize the user profile
          Provider.of<ProfileProvider>(context, listen: false).fetchUserProfile();
          return const BlogPostScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}

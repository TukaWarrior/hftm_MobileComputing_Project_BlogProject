import 'package:flutter_blog/screens/blogpost/blogpost.dart';
import 'package:flutter_blog/screens/home/home.dart';
import 'package:flutter_blog/screens/about/about.dart';
import 'package:flutter_blog/screens/blog/blog_new.dart';
import 'package:flutter_blog/screens/blog/blogoverview.dart';
import 'package:flutter_blog/screens/login/login.dart';
import 'package:flutter_blog/screens/profile/profile.dart';
import 'package:flutter_blog/screens/sensors/sensors.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/blogoverview': (context) => const BlogOverview(),
  '/blognew': (context) => BlogNewScreen(),
  '/sensors': (context) => const SensorsScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/blogpost': (context) => const BlogPostScreen(),
};

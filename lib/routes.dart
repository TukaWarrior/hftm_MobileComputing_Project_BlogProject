import 'package:blog_project/screens/about/about.dart';
import 'package:blog_project/screens/blog/blog_new.dart';
import 'package:blog_project/screens/blog/blog_detail.dart';
import 'package:blog_project/screens/blogpost/blogpost.dart';
import 'package:blog_project/screens/home/home.dart';
import 'package:blog_project/screens/sensors/sensors.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/blognew': (context) => const BlogNewScreen(),
  '/sensors': (context) => const SensorsScreen(),
  '/about': (context) => const AboutScreen(),
};

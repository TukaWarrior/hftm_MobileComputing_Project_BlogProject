import 'package:flutter_blog/screens/about/about.dart';
import 'package:flutter_blog/screens/blog/blog_new.dart';
import 'package:flutter_blog/screens/home/home.dart';
import 'package:flutter_blog/screens/sensors/sensors.dart';

var appRoutes = {
  '/': (context) => const HomeScreen(),
  '/blognew': (context) => const BlogNewScreen(),
  '/sensors': (context) => const SensorsScreen(),
  '/about': (context) => const AboutScreen(),
};

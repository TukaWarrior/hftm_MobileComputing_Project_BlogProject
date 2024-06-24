/// This file  initializes the Change Notifiers used across the application.
import 'package:provider/provider.dart';
import 'package:blog_project/providers/blog_provider.dart';

// ChangeNotifier for BlogProvider
ChangeNotifierProvider<BlogProvider> createBlogProvider() {
  return ChangeNotifierProvider<BlogProvider>(
    create: (_) => BlogProvider(),
  );
}

// import 'package:flutter/material.dart';
// import 'package:flutter_blog/models/blogpost.dart';
// import 'package:flutter_blog/screens/blogpost/blogpost.dart';
// import 'package:flutter_blog/screens/blogpost/blogpost_detail.dart';
// import 'package:flutter_blog/screens/blogpost/blogpost_item.dart';
// import 'package:flutter_blog/screens/blogpost/blogpost_screen.dart';
// import 'package:flutter_blog/screens/shared/error.dart';
// import 'package:flutter_blog/screens/shared/loading.dart';
// import 'package:flutter_blog/screens/shared/navigation_bar.dart';
// import 'package:flutter_blog/services/firestore.dart';

// class CategoryOverviewScreen extends StatelessWidget {
//   const CategoryOverviewScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder<List<BlogPost>>(
//       future: FirestoreService().getAllBlogPosts(),
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const LoadingScreen();
//         } else if (snapshot.hasError) {
//           return Center(
//             child: ErrorMessage(message: snapshot.error.toString()),
//           );
//         } else if (snapshot.hasData) {
//           var blogposts = snapshot.data!;
//           var recentBlogPost = blogposts.first; // Assuming the list is sorted by date, with the most recent first.
//           var categories = blogposts.map((post) => post.category).toSet().toList();

//           return Scaffold(
//             appBar: AppBar(
//               title: const Text('Home'),
//               backgroundColor: Colors.transparent,
//             ),
//             body: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   // Most Recent Blog Post Card
//                   _buildRecentBlogPostCard(context, recentBlogPost),

//                   const SizedBox(height: 20),

//                   // Categories Row
//                   const Text(
//                     'Categories',
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   const SizedBox(height: 10),
//                   _buildCategoryRow(context, categories),
//                 ],
//               ),
//             ),
//             bottomNavigationBar: const NavBar(),
//           );
//         } else {
//           return const Text('No blog posts found in Firestore.');
//         }
//       },
//     );
//   }

//   Widget _buildRecentBlogPostCard(BuildContext context, BlogPost blogpost) {
//     return Card(
//       clipBehavior: Clip.antiAlias,
//       child: InkWell(
//         onTap: () {
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (BuildContext context) => BlogPostDetailScreen(blogpost: blogpost),
//             ),
//           );
//         },
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             if (blogpost.imageURL.isNotEmpty)
//               Image.network(
//                 blogpost.imageURL,
//                 height: 200,
//                 fit: BoxFit.cover,
//                 width: double.infinity,
//               ),
//             Padding(
//               padding: const EdgeInsets.all(10),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     blogpost.title,
//                     style: Theme.of(context).textTheme.titleLarge,
//                     textAlign: TextAlign.left,
//                   ),
//                   const SizedBox(height: 10),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(
//                         blogpost.author,
//                         style: Theme.of(context).textTheme.labelLarge,
//                       ),
//                       Text(
//                         blogpost.publishedDate.toString().substring(0, 10),
//                         style: Theme.of(context).textTheme.labelLarge,
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildCategoryRow(BuildContext context, List<String> categories) {
//     return SizedBox(
//       height: 120, // Adjust as needed
//       child: ListView.builder(
//         scrollDirection: Axis.horizontal,
//         itemCount: categories.length,
//         itemBuilder: (context, index) {
//           return _buildCategoryCard(context, categories[index]);
//         },
//       ),
//     );
//   }

//   Widget _buildCategoryCard(BuildContext context, String category) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 16.0),
//       child: Card(
//         elevation: 4.0,
//         child: InkWell(
//           onTap: () {
//             // Navigate to BlogPostScreen with the selected category
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (BuildContext context) => BlogPostScreen(category: category), // Modify BlogPostScreen to accept category filter
//               ),
//             );
//           },
//           child: Container(
//             width: 100,
//             padding: const EdgeInsets.all(10),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Icon(Icons.category, size: 40), // Replace with category-specific icons if needed
//                 const SizedBox(height: 10),
//                 Text(
//                   category,
//                   style: Theme.of(context).textTheme.bodyMedium,
//                   textAlign: TextAlign.center,
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_blog/models/blogpost.dart';
import 'package:flutter_blog/models/profile.dart';
import 'package:flutter_blog/services/firestore.dart';

class BlogPostDetailScreen extends StatelessWidget {
  final BlogPost blogpost;

  const BlogPostDetailScreen({super.key, required this.blogpost});

  Future<Widget> _buildProfileRow(BuildContext context) async {
    Profile? userProfile;
    String displayName = 'Failed to fetch profile data'; // Default message
    userProfile = await FirestoreService().getProfileByUID(blogpost.userUID);
    if (userProfile != null) {
      displayName = userProfile.displayName;
    }

    return Row(
      children: [
        CircleAvatar(
          radius: 32.0,
          backgroundImage: NetworkImage(userProfile!.avatarURL),
        ),
        const SizedBox(width: 8),
        Text(
          displayName,
          style: Theme.of(context).textTheme.labelLarge,
        ),
        const Spacer(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: ListView(children: [
        Hero(
          tag: blogpost.imageURL, // This is not working
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              blogpost.imageURL,
              // height: 200, // Fixed height for a better layout
              // fit: BoxFit.cover,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null || (loadingProgress.cumulativeBytesLoaded == loadingProgress.expectedTotalBytes)) {
                  return child; // Display the image if loaded successfully
                } else {
                  return const SizedBox.shrink(); // Leave out the image if it fails to load
                }
              },
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox.shrink(); // Leave out the image if there is an error
              },
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                blogpost.title,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    blogpost.publishedDate.toString().substring(0, 10),
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    blogpost.category,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ],
              ),
              const Divider(
                thickness: 1.0,
                color: Color(0xFF6a6977),
                height: 32.0,
              ),
              FutureBuilder<Widget>(
                future: FirestoreService().getProfileByUID(blogpost.userUID).then((userProfile) {
                  String displayName = 'Failed to fetch profile data';
                  if (userProfile != null) {
                    displayName = userProfile.displayName;
                  }
                  return Row(
                    children: [
                      CircleAvatar(
                        radius: 32.0,
                        backgroundImage: NetworkImage(userProfile!.avatarURL),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        displayName,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ],
                  );
                }),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    return snapshot.data!;
                  }
                },
              ),
              const Divider(
                thickness: 1.0,
                color: Color(0xFF6a6977),
                height: 32.0,
              ),
              Text(
                blogpost.content,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              // Container(
              //   height: 64.0,
              //   margin: const EdgeInsets.only(top: 16.0),
              //   decoration: BoxDecoration(
              //     color: const Color(0xFF6a6977),
              //     borderRadius: BorderRadius.circular(12.0),
              //   ),
              //   child: const TextField(
              //     decoration: InputDecoration(
              //       border: InputBorder.none,
              //       hintText: "Write a comment...",
              //       hintStyle: TextStyle(fontSize: 15.0, color: Colors.grey),
              //     ),
              //   ),
              // )
            ],
          ),
        )
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_blog/models/blogpost.dart';
import 'package:flutter_blog/models/profile.dart';
import 'package:flutter_blog/screens/blogpost/blogpost_delete.dart';
import 'package:flutter_blog/screens/blogpost/blogpost_edit_dialog.dart'; // Import the new file
import 'package:flutter_blog/services/firestore.dart';
import 'package:flutter_blog/services/profile_provider.dart';
import 'package:provider/provider.dart';

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
    final currentUserProfile = Provider.of<ProfileProvider>(context).profile;
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Blog "),
            Text(
              "Post",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        actions: [
          if (currentUserProfile != null && currentUserProfile.documentID == blogpost.userUID) ...[
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => _showEditDialog(context), // Show edit dialog
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () => BlogPostDelete.showDeleteDialog(context, blogpost), // Use the extracted function
            ),
          ] else ...[
            const SizedBox(width: 48),
          ],
        ],
      ),
      body: ListView(children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: Divider(
            thickness: 1.0,
            color: Color(0xFF6a6977),
          ),
        ),
        Hero(
          tag: blogpost.imageURL,
          child: Card(
            clipBehavior: Clip.antiAlias,
            child: Image.network(
              blogpost.imageURL,
              width: double.infinity,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null || (loadingProgress.cumulativeBytesLoaded == loadingProgress.expectedTotalBytes)) {
                  return child;
                } else {
                  return const SizedBox.shrink();
                }
              },
              errorBuilder: (context, error, stackTrace) {
                return const SizedBox.shrink();
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
                    blogpost.publishedDate.toString().substring(0, 16),
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
            ],
          ),
        ),
      ]),
    );
  }

  void _showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => BlogPostEditDialog(blogpost: blogpost), // Open edit dialog
    );
  }
}

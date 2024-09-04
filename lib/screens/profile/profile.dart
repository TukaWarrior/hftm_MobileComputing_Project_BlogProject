import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/models/profile.dart' as AppUser;
import 'package:flutter_blog/screens/profile/profile_edit.dart';
import 'package:flutter_blog/screens/shared/navigation_bar.dart';
import 'package:flutter_blog/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<AppUser.Profile?> _getCurrentUserProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
      if (userDoc.exists) {
        return AppUser.Profile.fromJson(userDoc.data()!);
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: const NavBar(),
      body: FutureBuilder<AppUser.Profile?>(
        future: _getCurrentUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error loading profile.'));
          } else if (snapshot.hasData && snapshot.data != null) {
            final user = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (user.avatarURL.isNotEmpty)
                    CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(user.avatarURL),
                    ),
                  const SizedBox(height: 20),
                  Text('Name: ${user.displayName}', style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 10),
                  Text('Email: ${user.email}', style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 10),
                  Text('Description: ${user.description}', style: Theme.of(context).textTheme.bodyLarge),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    child: const Text('Edit Profile'),
                    onPressed: () {
                      // Navigate to the Edit Profile Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => EditProfileScreen(user: user)),
                      );
                    },
                  ),
                  ElevatedButton(
                    child: const Text('Sign Out'),
                    onPressed: () async {
                      final navigator = Navigator.of(context);
                      await AuthService().signOut();
                      navigator.pushNamedAndRemoveUntil('/', (route) => false);
                    },
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No profile data found.'));
          }
        },
      ),
    );
  }
}

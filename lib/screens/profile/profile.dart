import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blog/models/profile.dart';
import 'package:flutter_blog/screens/profile/profile_edit.dart';
import 'package:flutter_blog/screens/shared/navigation_bar.dart';
import 'package:flutter_blog/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Fetch the current user's profile from Firestore
  Future<Profile?> _getCurrentUserProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userDoc = await FirebaseFirestore.instance.collection('users').doc(currentUser.uid).get();
      if (userDoc.exists) {
        return Profile.fromJson(userDoc.data()!);
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
      body: Column(
        children: [
          FutureBuilder<Profile?>(
            future: _getCurrentUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return _buildErrorState('Error loading profile.');
              } else if (snapshot.hasData && snapshot.data != null) {
                return _buildProfileView(context, snapshot.data!);
              } else {
                return _buildErrorState('No profile data found.');
              }
            },
          ),
          ElevatedButton(
              child: const Text('signout'),
              onPressed: () async {
                final navigator = Navigator.of(context);
                await AuthService().signOut();
                // Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
                navigator.pushNamedAndRemoveUntil('/', (route) => false);
              }),
        ],
      ),
    );
  }

  // Method to build the profile view
  Widget _buildProfileView(BuildContext context, Profile user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: CircleAvatar(
              radius: 50,
              backgroundImage: user.avatarURL.isNotEmpty ? NetworkImage(user.avatarURL) : null,
              child: user.avatarURL.isEmpty ? const Icon(Icons.person, size: 50) : null,
            ),
          ),
          const SizedBox(height: 20),
          _buildProfileField('Name', user.displayName, context),
          _buildProfileField('Email', user.email, context),
          _buildProfileField('Description', user.description, context),
          const SizedBox(height: 20),
          _buildEditButton(context, user),
          _buildSignOutButton(context),
        ],
      ),
    );
  }

  // Method to build individual profile fields
  Widget _buildProfileField(String label, String value, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold)),
        const SizedBox(height: 5),
        Text(value, style: Theme.of(context).textTheme.bodyLarge),
        const SizedBox(height: 15),
      ],
    );
  }

  // Method to build the Edit Profile button
  Widget _buildEditButton(BuildContext context, Profile user) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.edit),
      label: const Text('Edit Profile'),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditProfileScreen(user: user)),
        );
      },
    );
  }

  // Method to build the Sign Out button
  Widget _buildSignOutButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.logout),
      label: const Text('Sign Out'),
      onPressed: () async {
        final navigator = Navigator.of(context);
        await AuthService().signOut();
        navigator.pushNamedAndRemoveUntil('/', (route) => false);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
    );
  }

  // Method to build the error state UI
  Widget _buildErrorState(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(message, style: const TextStyle(color: Colors.red, fontSize: 18)),
      ),
    );
  }
}

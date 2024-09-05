import 'package:flutter/material.dart';
import 'package:flutter_blog/models/profile.dart';
import 'package:flutter_blog/screens/profile/profile_edit.dart';
import 'package:flutter_blog/screens/shared/navigation_bar.dart';
import 'package:flutter_blog/services/auth.dart';
import 'package:flutter_blog/services/profile_provider.dart';
import 'package:provider/provider.dart'; // Import provider

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: const NavBar(),
      body: Consumer<ProfileProvider>(
        // Use Consumer to listen to ProfileProvider
        builder: (context, profileProvider, child) {
          final userProfile = profileProvider.profile; // Access the profile from provider

          if (userProfile == null) {
            // If the profile is still being fetched or does not exist, show loading or error
            return const Center(child: CircularProgressIndicator());
          }

          // If the profile is loaded successfully, show the profile view
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: userProfile.avatarURL.isNotEmpty
                      ? ClipOval(
                          // Clip the image to make it circular
                          child: Image.network(
                            userProfile.avatarURL,
                            height: 100, // Adjust height and width for a circular avatar
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const CircleAvatar(
                          radius: 50,
                          child: Icon(Icons.person, size: 50),
                        ),
                ),
                const SizedBox(height: 20),
                _buildProfileField('Name', userProfile.displayName, context),
                _buildProfileField('Email', userProfile.email, context),
                _buildProfileField('Description', userProfile.description, context),
                const SizedBox(height: 20),
                _buildEditButton(context, userProfile, profileProvider), // Pass profileProvider to refresh profile after editing
                _buildSignOutButton(context),
              ],
            ),
          );
        },
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
  Widget _buildEditButton(BuildContext context, Profile user, ProfileProvider profileProvider) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.edit),
      label: const Text('Edit Profile'),
      onPressed: () async {
        await Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => EditProfileScreen(user: user)),
        );

        // Refresh the profile after returning from the EditProfileScreen
        profileProvider.fetchUserProfile();
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
}

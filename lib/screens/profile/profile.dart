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
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: 48,
            ),
            Text('My '),
            Text(
              'Profile',
              style: TextStyle(
                fontSize: 22,
                color: Colors.blue,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => _showEditDialog(context), // Show edit dialog
          ),
        ],
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
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Divider(
                  thickness: 1.0,
                  color: Color(0xFF6a6977),
                ),
                Center(
                  child: userProfile.avatarURL.isNotEmpty
                      ? ClipOval(
                          // Clip the image to make it circular
                          child: Image.network(
                            userProfile.avatarURL,
                            height: 250, // Adjust height and width for a circular avatar
                            width: 250,
                            fit: BoxFit.cover,
                          ),
                        )
                      : const CircleAvatar(
                          radius: 125,
                          child: Icon(Icons.person, size: 50),
                        ),
                ),
                const Divider(
                  thickness: 1.0,
                  color: Color(0xFF6a6977),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    userProfile.displayName,
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),

                const SizedBox(
                  height: 16,
                ),

                Align(
                  alignment: Alignment.center,
                  child: Text(
                    userProfile.description,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                // Display Profile Created Date
                Text(
                  'Profile created:',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  userProfile.createdDate.toString().substring(0, 10),
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const SizedBox(height: 20),

                // Display Email
                Text(
                  'Email:',
                  style: Theme.of(context).textTheme.labelLarge,
                ),
                Text(
                  userProfile.email,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),

                const Divider(
                  thickness: 1.0,
                  color: Color(0xFF6a6977),
                ),

                _buildSignOutButton(context),
              ],
            ),
          );
        },
      ),
    );
  }

  // Method to show the Edit Profile dialog
  void _showEditDialog(BuildContext context) async {
    final profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    final userProfile = profileProvider.profile;

    if (userProfile != null) {
      await Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => EditProfileScreen(user: userProfile)),
      );

      // Refresh the profile after returning from the EditProfileScreen
      profileProvider.fetchUserProfile();
    }
  }

  Widget _buildSignOutButton(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.logout),
      label: const Text('Sign Out'),
      onPressed: () async {
        // Sign out the user
        await AuthService().signOut();
        // Clear the profile data in the ProfileProvider
        Provider.of<ProfileProvider>(context, listen: false).clearProfile();
        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
      ),
    );
  }
}

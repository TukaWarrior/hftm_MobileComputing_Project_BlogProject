import 'package:flutter/material.dart';
import 'package:flutter_blog/models/profile.dart';
import 'package:flutter_blog/services/auth.dart';
import 'package:flutter_blog/services/firestore.dart';

class ProfileProvider with ChangeNotifier {
  Profile? _profile;
  final FirestoreService _firestoreService = FirestoreService();

  Profile? get profile => _profile;

  Future<void> fetchUserProfile() async {
    try {
      var user = AuthService().user;
      final fetchedProfile = await _firestoreService.getProfile();
      if (fetchedProfile != null) {
        _profile = fetchedProfile;
        notifyListeners(); // Notify listeners to update UI when profile data changes
      } else {
        // If the profile doesn't exist, create a new one
        final newProfile = Profile(
          displayName: 'New User',
          description: 'New Description',
          email: user!.email ?? '', // Or get email from auth service
          avatarURL: '',
          createdDate: DateTime.now(),
        );
        await _firestoreService.createOrUpdateProfile(newProfile);
        _profile = newProfile;
        notifyListeners();
      }
    } catch (e) {
      throw Exception('Failed to fetch or create user profile: $e');
    }
  }

  Future<void> updateUserProfile(Profile updatedProfile) async {
    try {
      await _firestoreService.createOrUpdateProfile(updatedProfile);
      _profile = updatedProfile;
      notifyListeners(); // Notify listeners to update UI when profile data changes
    } catch (e) {
      throw Exception('Failed to update user profile: $e');
    }
  }

  void clearProfile() {
    _profile = null;
    notifyListeners(); // Notify listeners to clear the UI
  }
}

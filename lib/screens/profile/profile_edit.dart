import 'package:flutter/material.dart';
import 'package:flutter_blog/models/profile.dart' as AppUser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_blog/services/profile_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_blog/services/firestore.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  final AppUser.Profile user;

  const EditProfileScreen({super.key, required this.user});

  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  File? _image; // To store the selected image
  final picker = ImagePicker();
  final FirestoreService _firestoreService = FirestoreService(); // Initialize FirestoreService

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.displayName);
    _descriptionController = TextEditingController(text: widget.user.description);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Edit my "),
            Text(
              "Profile",
              style: TextStyle(
                fontSize: 22,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              width: 48,
            )
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Divider(
                thickness: 1.0,
                color: Color(0xFF6a6977),
              ),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Display Name'),
                validator: (value) => value!.isEmpty ? 'Please enter a name' : null,
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                validator: (value) => value!.isEmpty ? 'Please enter a description' : null,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.camera),
                    label: const Text('Camera'),
                    onPressed: _getImageFromCamera,
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.photo),
                    label: const Text('Gallery'),
                    onPressed: _getImageFromGallery,
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                child: const Text('Save Changes'),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await _updateUserProfile();
                    Navigator.pop(context); // Go back to profile screen
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _getImageFromCamera() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
    Provider.of<ProfileProvider>(context, listen: false).fetchUserProfile();
  }

  Future<void> _updateUserProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String? avatarURL;
      if (_image != null) {
        // Upload image to Firebase Storage
        avatarURL = await _firestoreService.uploadAvatarImage(_image!, currentUser.uid);
      }

      // Update the user's profile with the new data
      final updatedProfile = AppUser.Profile(
        displayName: _nameController.text,
        description: _descriptionController.text,
        email: widget.user.email,
        avatarURL: avatarURL ?? '',
        createdDate: widget.user.createdDate,
      );

      await FirestoreService().createOrUpdateProfile(updatedProfile);
    }
  }
}

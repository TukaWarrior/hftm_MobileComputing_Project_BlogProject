import 'package:flutter/material.dart';
import 'package:flutter_blog/models/profile.dart' as AppUser;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  late TextEditingController _avatarURLController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.user.displayName);
    _descriptionController = TextEditingController(text: widget.user.description);
    _avatarURLController = TextEditingController(text: widget.user.avatarURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              const SizedBox(height: 10),
              TextFormField(
                controller: _avatarURLController,
                decoration: const InputDecoration(labelText: 'Avatar URL'),
                validator: (value) => value!.isEmpty ? 'Please enter an avatar URL' : null,
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

  Future<void> _updateUserProfile() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      final userRef = FirebaseFirestore.instance.collection('users').doc(currentUser.uid);
      await userRef.update({
        'displayName': _nameController.text,
        'description': _descriptionController.text,
        'avatarURL': _avatarURLController.text,
      });
    }
  }
}

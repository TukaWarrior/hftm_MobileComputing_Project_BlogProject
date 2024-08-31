import 'package:flutter/material.dart';
import 'package:flutter_blog/main.dart';
import 'package:flutter_blog/services/auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ElevatedButton(
          child: const Text('signout'),
          onPressed: () async {
            final navigator = Navigator.of(context);
            await AuthService().signOut();
            // Navigator.of(context).pushNamedAndRemoveUntil('/', (route) => false);
            navigator.pushNamedAndRemoveUntil('/', (route) => false);
          }),
    );
  }
}

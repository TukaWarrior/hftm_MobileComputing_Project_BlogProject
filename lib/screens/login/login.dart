import 'package:flutter/material.dart';
import 'package:flutter_blog/services/auth.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const FlutterLogo(
              size: 150,
            ),
            Flexible(
              child: LoginButton(
                text: "Continue as Guest",
                icon: Icons.face_outlined,
                color: Colors.deepPurple,
                loginMethod: AuthService().anonymousLogin,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class LoginButton extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String text;
  final Function loginMethod;

  const LoginButton({super.key, required this.text, required this.icon, required this.color, required this.loginMethod});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: ElevatedButton.icon(
        icon: Icon(
          icon,
          color: Colors.white,
          size: 20,
        ),
        style: TextButton.styleFrom(
          padding: const EdgeInsets.all(24),
          backgroundColor: color,
        ),
        onPressed: () async {
          try {
            await loginMethod(); // Call the login method
            Navigator.pushReplacementNamed(context, '/'); // Navigate to the home screen
          } catch (e) {
            // Handle login error (optional)
          }
        },
        // onPressed: () => loginMethod,
        label: Text(text),
      ),
    );
  }
}

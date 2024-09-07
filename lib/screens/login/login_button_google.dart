import 'package:flutter/material.dart';
import 'package:flutter_blog/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginButtonGoogle extends StatelessWidget {
  final AuthService authService;

  const LoginButtonGoogle({
    super.key,
    required this.authService,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _signInWithGoogle(context),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      icon: const FaIcon(FontAwesomeIcons.google),
      label: const Text('Google'),
    );
  }

  Future<void> _signInWithGoogle(BuildContext context) async {
    try {
      await authService.googleLogin();
      Navigator.pushReplacementNamed(context, '/');
    } catch (e) {
      _showErrorDialog(context, e.toString());
    }
  }

  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_blog/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginButtonGuest extends StatelessWidget {
  final AuthService authService;

  const LoginButtonGuest({
    super.key,
    required this.authService,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: () => _signInAnonymously(context),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      icon: const FaIcon(FontAwesomeIcons.userNinja),
      label: const Text('Guest'),
    );
  }

  Future<void> _signInAnonymously(BuildContext context) async {
    try {
      await authService.anonymousLogin();
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

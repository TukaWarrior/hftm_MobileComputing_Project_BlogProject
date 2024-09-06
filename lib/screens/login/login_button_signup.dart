import 'package:flutter/material.dart';
import 'package:flutter_blog/services/auth.dart';

class LoginButtonSignUp extends StatelessWidget {
  final AuthService authService;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final GlobalKey<FormState> formKey; // Pass the Form key to validate form inputs

  const LoginButtonSignUp({
    super.key,
    required this.authService,
    required this.emailController,
    required this.passwordController,
    required this.formKey,
  });

  Future<void> _registerWithEmail(BuildContext context) async {
    if (formKey.currentState!.validate()) {
      try {
        await authService.registerWithEmail(emailController.text, passwordController.text);
        Navigator.pushReplacementNamed(context, '/');
      } catch (e) {
        _showErrorDialog(context, e.toString());
      }
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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () => _registerWithEmail(context),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Less rounded, more like a card
          ),
        ),
        child: const Text('SIGN UP'),
      ),
    );
  }
}

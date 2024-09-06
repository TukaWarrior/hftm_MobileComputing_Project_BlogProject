import 'package:flutter/material.dart';
import 'package:flutter_blog/services/auth.dart';

class LoginForgotPasswordButton extends StatelessWidget {
  final AuthService authService;

  const LoginForgotPasswordButton({super.key, required this.authService});

  void _showResetPasswordDialog(BuildContext context) {
    final TextEditingController emailController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset Password'),
        content: TextFormField(
          controller: emailController,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            labelText: 'Enter your email',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              final email = emailController.text.trim();
              if (email.isNotEmpty) {
                try {
                  await authService.resetPassword(email);
                  Navigator.of(context).pop(); // Close the dialog
                  _showConfirmationDialog(context, 'Password reset email sent!');
                } catch (e) {
                  Navigator.of(context).pop(); // Close the dialog
                  _showErrorDialog(context, e.toString());
                }
              }
            },
            child: const Text('Send Email'),
          ),
        ],
      ),
    );
  }

  void _showConfirmationDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Success'),
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
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () => _showResetPasswordDialog(context),
        child: const Text('Forgot Password?'),
      ),
    );
  }
}

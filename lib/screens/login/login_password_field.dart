import 'package:flutter/material.dart';

class LoginPasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  final bool obscurePassword;
  final VoidCallback togglePasswordVisibility;

  const LoginPasswordField({
    super.key,
    required this.passwordController,
    required this.obscurePassword,
    required this.togglePasswordVisibility,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: passwordController,
      obscureText: obscurePassword,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(obscurePassword ? Icons.visibility : Icons.visibility_off),
          onPressed: togglePasswordVisibility,
        ),
        hintText: 'Enter your Password',
      ),
      validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
    );
  }
}

import 'package:flutter/material.dart';

class LoginEmailField extends StatelessWidget {
  final TextEditingController emailController;

  const LoginEmailField({
    super.key,
    required this.emailController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        prefixIcon: Icon(Icons.email),
        hintText: 'Enter your Email',
      ),
      validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
    );
  }
}

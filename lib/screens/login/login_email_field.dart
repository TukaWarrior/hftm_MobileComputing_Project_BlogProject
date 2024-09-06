import 'package:flutter/material.dart';

class LoginEmailField extends StatelessWidget {
  final TextEditingController emailController;

  const LoginEmailField({
    Key? key,
    required this.emailController,
  }) : super(key: key);

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

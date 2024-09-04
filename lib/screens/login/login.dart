import 'package:flutter/material.dart';
import 'package:flutter_blog/services/auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final AuthService _authService = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        backgroundColor: Colors.transparent,
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
            Form(
              key: _formKey,
              child: Column(
                children: [
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(labelText: 'Email'),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    controller: _passwordController,
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
                  ),
                  SizedBox(height: 20),
                  LoginButton(
                    text: "Login with Email",
                    icon: Icons.email,
                    color: Colors.teal,
                    loginMethod: _loginWithEmail,
                  ),
                  LoginButton(
                    text: "Register with Email",
                    icon: Icons.person_add,
                    color: Colors.green,
                    loginMethod: _registerWithEmail,
                  ),
                ],
              ),
            ),
            LoginButton(
              text: "Sign in with Google",
              icon: FontAwesomeIcons.google,
              color: Colors.blue,
              loginMethod: _authService.googleLogin,
            ),
            LoginButton(
              text: "Continue as Guest",
              icon: FontAwesomeIcons.userNinja,
              color: Colors.deepPurple,
              loginMethod: _authService.anonymousLogin,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _loginWithEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _authService.emailLogin(_emailController.text, _passwordController.text);
        Navigator.pushReplacementNamed(context, '/');
      } catch (e) {
        _showErrorDialog(e.toString());
      }
    }
  }

  Future<void> _registerWithEmail() async {
    if (_formKey.currentState!.validate()) {
      try {
        await _authService.registerWithEmail(_emailController.text, _passwordController.text);
        Navigator.pushReplacementNamed(context, '/');
      } catch (e) {
        _showErrorDialog(e.toString());
      }
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Error'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('OK'),
          ),
        ],
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
        label: Text(text),
      ),
    );
  }
}

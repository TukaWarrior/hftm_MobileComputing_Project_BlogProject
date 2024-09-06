import 'package:flutter/material.dart';
import 'package:flutter_blog/main.dart';
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
  bool _obscurePassword = true; // Control password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Sign  ",
              // style: TextTheme(displayLarge),
            ),
            Text(
              "In",
              style: TextStyle(fontSize: 22, color: Colors.blue),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const SizedBox(height: 30.0),
                _buildEmailField(),
                const SizedBox(height: 30.0),
                _buildPasswordField(),
                _buildForgotPasswordBtn(),
                const SizedBox(height: 10.0),
                _buildSignInButton(),
                _buildSignUpButton(),
                const SizedBox(height: 20.0),
                _buildSignInWithText(),
                _buildSocialSignInButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return TextFormField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        border: InputBorder.none,
        filled: true,
        contentPadding: EdgeInsets.only(top: 14.0),
        prefixIcon: Icon(Icons.email),
        hintText: 'Enter your Email',
      ),
      validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        contentPadding: const EdgeInsets.only(top: 14.0),
        prefixIcon: const Icon(Icons.lock),
        suffixIcon: IconButton(
          icon: Icon(_obscurePassword ? Icons.visibility : Icons.visibility_off),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        hintText: 'Enter your Password',
      ),
      validator: (value) => value!.isEmpty ? 'Please enter a password' : null,
    );
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: TextButton(
        onPressed: () {
          // TODO: Implement forgot password functionality
        },
        child: const Text('Forgot Password?'),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _loginWithEmail,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0), // Less rounded, more like a card
          ),
        ),
        child: const Text('SIGN IN'),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _registerWithEmail,
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

  Widget _buildSignInWithText() {
    return Column(
      children: const [
        Text('- OR -'),
        SizedBox(height: 20.0),
        Text('Sign in with'),
      ],
    );
  }

  Widget _buildSocialSignInButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialBtn(
          () => _authService.googleLogin(),
          FontAwesomeIcons.google, // Added FontAwesome icon
          'Google',
        ),
        _buildSocialBtn(
          () => _authService.anonymousLogin(),
          FontAwesomeIcons.userNinja, // Added FontAwesome icon
          'Guest',
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, IconData icon, String label) {
    return ElevatedButton.icon(
      onPressed: () => onTap(),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Less rounded, more like a card
        ),
      ),
      icon: FaIcon(icon), // Use FontAwesome icon
      label: Text(label),
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

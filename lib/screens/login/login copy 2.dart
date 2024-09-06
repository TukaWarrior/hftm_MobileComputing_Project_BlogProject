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
  bool _obscurePassword = true; // Control password visibility

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF73AEF5),
                Color(0xFF61A4F1),
                Color(0xFF478DE0),
                Color(0xFF398AE5),
              ],
              stops: [0.1, 0.4, 0.7, 0.9],
            ),
          ),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'Sign In',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'OpenSans',
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
      style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
      decoration: const InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: Color(0xFF6CA8F1),
        contentPadding: EdgeInsets.only(top: 14.0),
        prefixIcon: Icon(
          Icons.email,
          color: Colors.white,
        ),
        hintText: 'Enter your Email',
        hintStyle: TextStyle(color: Colors.white54),
      ),
      validator: (value) => value!.isEmpty ? 'Please enter an email' : null,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      style: const TextStyle(color: Colors.white, fontFamily: 'OpenSans'),
      decoration: InputDecoration(
        border: InputBorder.none,
        filled: true,
        fillColor: const Color(0xFF6CA8F1),
        contentPadding: const EdgeInsets.only(top: 14.0),
        prefixIcon: const Icon(
          Icons.lock,
          color: Colors.white,
        ),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: () {
            setState(() {
              _obscurePassword = !_obscurePassword;
            });
          },
        ),
        hintText: 'Enter your Password',
        hintStyle: const TextStyle(color: Colors.white54),
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
        child: const Text(
          'Forgot Password?',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _buildSignInButton() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: ElevatedButton(
        onPressed: _loginWithEmail,
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(15.0),
          // primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: const Text(
          'SIGN IN',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
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
          // primary: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
        ),
        child: const Text(
          'SIGN UP',
          style: TextStyle(
            color: Color(0xFF527DAA),
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  Widget _buildSignInWithText() {
    return Column(
      children: const [
        Text(
          '- OR -',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(height: 20.0),
        Text(
          'Sign in with',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildSocialSignInButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildSocialBtn(
          () => _authService.googleLogin(),
          const AssetImage('assets/logos/google.jpg'),
        ),
        _buildSocialBtn(
          () => _authService.anonymousLogin(),
          const AssetImage('assets/logos/anonymous.jpg'),
        ),
      ],
    );
  }

  Widget _buildSocialBtn(Function onTap, AssetImage logo) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        height: 60.0,
        width: 60.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(0, 2),
              blurRadius: 6.0,
            ),
          ],
          image: DecorationImage(
            image: logo,
          ),
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

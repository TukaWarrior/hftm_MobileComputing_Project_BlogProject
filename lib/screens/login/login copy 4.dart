// import 'package:flutter/material.dart';
// import 'package:flutter_blog/services/auth.dart';
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'login_button_signin.dart';
// import 'login_button_signup.dart';
// import 'login_button_google.dart';
// import 'login_button_guest.dart';
// import 'login_email_field.dart';
// import 'login_password_field.dart';
// import 'login_forgot_password_button.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final AuthService _authService = AuthService();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   bool _obscurePassword = true; // Control password visibility

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text("Sign  "),
//             Text("In", style: TextStyle(fontSize: 22, color: Colors.blue)),
//           ],
//         ),
//         backgroundColor: Colors.transparent,
//       ),
//       body: GestureDetector(
//         onTap: () => FocusScope.of(context).unfocus(),
//         child: Container(
//           height: double.infinity,
//           width: double.infinity,
//           child: SingleChildScrollView(
//             physics: const AlwaysScrollableScrollPhysics(),
//             padding: const EdgeInsets.symmetric(horizontal: 40.0, vertical: 100.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 const SizedBox(height: 30.0),
//                 LoginEmailField(emailController: _emailController),
//                 const SizedBox(height: 30.0),
//                 LoginPasswordField(
//                   passwordController: _passwordController,
//                   obscurePassword: _obscurePassword,
//                   togglePasswordVisibility: () {
//                     setState(() {
//                       _obscurePassword = !_obscurePassword;
//                     });
//                   },
//                 ),
//                 LoginForgotPasswordButton(),
//                 const SizedBox(height: 10.0),
//                 LoginButtonSignIn(
//                   authService: _authService,
//                   emailController: _emailController,
//                   passwordController: _passwordController,
//                   formKey: _formKey,
//                 ),
//                 LoginButtonSignUp(
//                   authService: _authService,
//                   emailController: _emailController,
//                   passwordController: _passwordController,
//                   formKey: _formKey,
//                 ),
//                 const SizedBox(height: 20.0),
//                 Column(
//                   children: const [
//                     SizedBox(height: 20.0),
//                     Text('Sign in with'),
//                   ],
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: [
//                     LoginButtonGoogle(authService: _authService),
//                     LoginButtonGuest(authService: _authService),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

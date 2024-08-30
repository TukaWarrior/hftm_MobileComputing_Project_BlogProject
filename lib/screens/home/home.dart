import 'package:flutter/material.dart';
import 'package:flutter_blog/screens/blog/blogoverview.dart';
import 'package:flutter_blog/screens/login/login.dart';
import 'package:flutter_blog/services/auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AuthService().userStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading');
        } else if (snapshot.hasError) {
          return const Center(
            child: Text('Error'),
          );
        } else if (snapshot.hasData) {
          return const BlogOverview();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:quizapp/login/login.dart';
// import 'package:quizapp/shared/shared.dart';
// import 'package:quizapp/topics/topics.dart';
// import 'package:quizapp/services/auth.dart';

// class HomeScreen extends StatelessWidget {
//   const HomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: AuthService().userStream,
//       builder: (context, snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const LoadingScreen();
//         } else if (snapshot.hasError) {
//           return const Center(
//             child: ErrorMessage(),
//           );
//         } else if (snapshot.hasData) {
//           return const TopicsScreen();
//         } else {
//           return const LoginScreen();
//         }
//       },
//     );
//   }
// }
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final userStream =
      FirebaseAuth.instance.authStateChanges(); // Accessing the firebase user asynchronously through a stream. Used when e.g. the UI should react to an auth state change, but the time of when that change is going to happen is unknown.
  final user = FirebaseAuth.instance.currentUser; // Accessing the firebase user synchronously by calling FirebaseAuth. instance. Used when e.g. the user clicks a button and the authentication state has to change in that moment.

  Future<void> anonymousLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException catch (e) {
      // handle error
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final userStream =
      FirebaseAuth.instance.authStateChanges(); // Accessing the firebase user asynchronously through a stream. Used when e.g. the UI should react to an auth state change, but the time of when that change is going to happen is unknown.
  final user = FirebaseAuth.instance.currentUser; // Accessing the firebase user synchronously by calling FirebaseAuth. instance. Used when e.g. the user clicks a button and the authentication state has to change in that moment.

  Future<void> anonymousLogin() async {
    try {
      await FirebaseAuth.instance.signInAnonymously();
    } on FirebaseAuthException {
      // Handle error
    }
  }

  Future<void> googleLogin() async {
    // https://firebase.flutter.dev/docs/auth/social
    try {
      // Trigger the authentication flow
      final googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) return;
      // Obtain the auth details from the request
      final googleAuth = await googleUser.authentication;
      // Create a new credential
      final authCredential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(authCredential);
    } on FirebaseAuthException {
      // Handle error
    }
  }

  Future<void> emailLogin(String email, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print('Error during email login: $e');
      throw e; // Throw error to be handled by UI
    }
  }

  Future<void> registerWithEmail(String email, String password) async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      print('Error during registration: $e');
      throw e; // Throw error to be handled by UI
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      print('Error sending password reset email: $e');
      throw e; // Throw error to be handled by UI
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}

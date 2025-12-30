import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signup(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Signup failed';
    }
  }

  Future<UserCredential> signin(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw e.message ?? 'Login failed';
    }
  }

  Future<bool> signInWithGoogle() async {
    try {
      if (kIsWeb) {
        // Web: Firebase popup (unchanged – works perfectly)
        GoogleAuthProvider googleProvider = GoogleAuthProvider();
        googleProvider.setCustomParameters({'prompt': 'select_account'});

        await FirebaseAuth.instance.signInWithPopup(googleProvider);
        print('/////// Google Sign-In Success (Web) ////////');
        return true;
      } else {
        // Mobile: Use singleton + authenticate() (correct for v7+)
        final GoogleSignInAccount? googleUser =
            await GoogleSignIn.instance.authenticate();

        if (googleUser == null) {
          print('Google Sign-In cancelled');
          return false;
        }

        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        if (googleAuth.idToken == null) {
          print('No idToken received');
          return false;
        }

        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
        );

        await FirebaseAuth.instance.signInWithCredential(credential);
        print('/////// Google Sign-In Success (Mobile) ////////');
        return true;
      }
    } on FirebaseAuthException catch (e) {
      print('Firebase Auth Error: ${e.code}');
      return false;
    } catch (e) {
      print('Google Sign-In Error: $e');
      return false;
    }
  }

  // Sign out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    if (!kIsWeb) {
      await GoogleSignIn.instance.signOut();
    }
    print('/////// Signed Out ////////');
  }
}

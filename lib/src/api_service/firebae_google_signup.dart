import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices {
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();

 
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the Google authentication flow
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
      if (gUser == null) {
        // User cancelled the sign-in
        return null;
      }

      // Obtain the auth details from the request
      final GoogleSignInAuthentication gAuth = await gUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );

      // Sign in to Firebase with the credential
      final userCredential = await _auth.signInWithCredential(credential);

      // Get the Firebase ID token (JWT)
      final idToken = await userCredential.user;
      print("id toke === >  $idToken");
      return idToken;
    } catch (e) {
      print('Google Sign-In error: $e');
      rethrow;
    }
  }

  /// Optional: Sign out from both Firebase and Google
  Future<void> googleSignOut() async {
    await _auth.signOut();
    await _googleSignIn.signOut();
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final GoogleSignIn googleSignIn = GoogleSignIn();

  /// Google sign in
  Future<UserCredential?> signInWithGoogle() async {
    /// Begin interactive sign-in process
    final GoogleSignInAccount? gUser = await googleSignIn.signIn();

    if (gUser == null) {
      /// The user canceled the sign-in
      return null;
    }

    /// Obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    /// Create a new credential for the user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    /// Finally, let's sign in
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }
}

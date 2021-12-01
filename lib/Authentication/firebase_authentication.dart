import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FireBaseAuthHelper {

  /// Register Suer With Personal Email and Password
  static Future<User?> registerUsingEmailPassword ({
      required String email, 
      required String password
    }) async {
    
    // Create a FirebaseAuth Instance
    FirebaseAuth auth = FirebaseAuth.instance;
    // Creaate a User 
    User? user;

    try {
      // Register user to Firebase with Email and password , Save the User Credential
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      user = userCredential.user;
    } on FirebaseAuthException catch(err) {
      // Catch any Firebase Exception
    }
    catch(err) {
      // print(err);
    }
    return user;
  }

  /// SignIn User With Email and Password
  static Future<User?> signInUsingEmailPassword({
    required String email, 
    required String password
  }) async {
    
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);
      user = userCredential.user;
    } on FirebaseAuthException catch (err) {
      //
    }

    return user;
  }

  // Google Sign In User
  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if(googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken
      );

      try {
        final UserCredential userCredential = await auth.signInWithCredential(credential);
        user = userCredential.user;
      } on FirebaseAuthException catch(err) {
        // ignore: avoid_print
        print(err.code);
        if(err.code == 'account-exists-with-different-credential') {
          //
        }
      } catch (e) {
        // ignore: avoid_print
        print(e);
      }
    }
    
    return user;
  }

  static Future<void> signOutuser() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<User?> getCurrentLoggedInUser() async {
  
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    User? user = firebaseAuth.currentUser;

    return user; 
  }

}

import 'package:firebase_auth/firebase_auth.dart';

class FireBaseAuthHelper {

  /// Register Suer With Personal Email and Password
  static Future<User?> registerUsingEmailPassword({
      required String email, 
      required String password
    }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (err) {
      if (err.code == "weak-password") {
        //
      } else if (err.code == "email-already-in-use") {
        //
      }
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
}

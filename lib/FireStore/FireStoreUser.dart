/**
 * All Function Related to User table in Firestore
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreUserHelper {
  static Future<void> addUserToDataBase(User? user) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    CollectionReference _registeredUsers =
        _fireStore.collection('registeredUsers');

    Map<String, dynamic> data = <String, dynamic>{
      "Email_id": user?.email,
      "Photo_url": user?.photoURL,
      "display_name": user?.displayName,
    };

    try {
      _registeredUsers.doc(user?.uid).set(data);
    } catch (err) {
      print(err);
    }
  }
}

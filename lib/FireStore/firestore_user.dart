/**
 * All Function Related to User table in Firestore
 */

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FireStoreUserHelper {

  /** Data Members of User Collection Class */
  String emailId;
  String photoUrl;
  String displayName;

  FireStoreUserHelper(this.emailId , this.photoUrl , this.displayName);

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
      // ignore: avoid_print
      print(err);
    }
  }

  /**
   * Get the User Details from the fireStore
   */
  static Future<FireStoreUserHelper?> getUserDetails(User? user) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    CollectionReference _registeredUsers = _fireStore.collection('registeredUsers');

    late FireStoreUserHelper? _currentUser;

    try {
      await _registeredUsers.doc(user?.uid).get()
      .then((DocumentSnapshot) => {
        _currentUser = FireStoreUserHelper(DocumentSnapshot['Email_id'], DocumentSnapshot['Photo_url'], DocumentSnapshot['display_name'])
      });
    } catch(err) {
      // ignore: avoid_print
      print(err);
    }
    return _currentUser;
  }

  /**
   * Update User Display Name in FireStore
   */
  static Future<void> updateUserDisplayName(User? user , String? displayName) async {
    FirebaseFirestore _fireStore = FirebaseFirestore.instance;
    CollectionReference _registeredUsers = _fireStore.collection('registeredUsers');

    try {
      await _registeredUsers.doc(user!.uid).update({"display_name" : displayName as String});
    } catch(err) {
      // ignore: avoid_print
      print(err);
    }

  }
}

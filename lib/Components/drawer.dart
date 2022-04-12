import 'package:be_isear/Authentication/firebase_authentication.dart';
import 'package:be_isear/FireStore/firestore_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  final User user = FirebaseAuth.instance.currentUser as User;

  /**
   * Get the current User Detail from the FireStore
   */
  Future<FireStoreUserHelper?> getCurrenUser() async {
    FireStoreUserHelper? _currentUser = await FireStoreUserHelper.getUserDetails(user);
    return _currentUser;
  }

  Widget getUSerAccountsDrawerHeader(String userEmail , String? photoURL , String? displayName) {
    if (photoURL == null) {
      return UserAccountsDrawerHeader(
        accountEmail: Text(
          userEmail,
          style: GoogleFonts.caveat(
              letterSpacing: 2.0,
              textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        accountName: Text(
          displayName ?? '',
          style: GoogleFonts.caveat(
              letterSpacing: 2.0,
              textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        decoration: const BoxDecoration(color: Colors.white70),
      );
    } else {
      return UserAccountsDrawerHeader(
        currentAccountPicture: CircleAvatar(
          backgroundImage: NetworkImage(photoURL),
        ),
        accountEmail: Text(
          userEmail,
          style: GoogleFonts.caveat(
              letterSpacing: 2.0,
              textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        accountName: Text(
          displayName as String,
          style: GoogleFonts.caveat(
              letterSpacing: 2.0,
              textStyle: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        decoration: const BoxDecoration(color: Colors.white70),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          FutureBuilder(
            future: getCurrenUser(),
            builder: (BuildContext context , AsyncSnapshot<FireStoreUserHelper?> snapshot) {
              if(snapshot.connectionState == ConnectionState.done) {
                return getUSerAccountsDrawerHeader(snapshot.data!.emailId, snapshot.data!.photoUrl, snapshot.data!.displayName);
              }
              return Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  height: 30.0,
                  width: 30.0,
                  child: const CircularProgressIndicator(
                    color: Colors.black,
                  )
                ),
              );
            },  
          ),
          ListTile(
            leading: const Icon(Icons.house),
            title: Text(
              'Home',
              style: GoogleFonts.caveat(),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: Text(
              'Help',
              style: GoogleFonts.caveat(),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.feedback),
            title: Text(
              'FeedBack',
              style: GoogleFonts.caveat(),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: Text(
              'Invite Friends',
              style: GoogleFonts.caveat(),
            ),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: Text(
              'Rate the App',
              style: GoogleFonts.caveat(),
            ),
            onTap: () {},
          ),
          const SizedBox(height: 100),
          const Divider(
            height: 20.0,
            indent: 5.0,
            endIndent: 5.0,
          ),
          ListTile(
            trailing: const Icon(Icons.power_settings_new_outlined),
            title: Text(
              'Sign Out',
              style: GoogleFonts.caveat(),
            ),
            onTap: () async {
              await FireBaseAuthHelper.signOutuser();
              Navigator.of(context).pushNamedAndRemoveUntil(
                  '/login', (Route<dynamic> route) => false);
            },
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';

import 'package:be_isear/FireStore/firestore_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {

  final User user = FirebaseAuth.instance.currentUser as User;

  bool _isEditingText = false;
  late TextEditingController _editingController;
  // String displayName = " ";

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }
  /**
   * Get the Current User Details from FireStore
   */
  Future<FireStoreUserHelper?> getCurrentUserFromFireBase() async {
    User user = FirebaseAuth.instance.currentUser as User;
    return await FireStoreUserHelper.getUserDetails(user);
  }


  Widget profileAreaBuilder(String? displayName, String? emailId, String? photoUrl) {
    return(
      Container(
        width: MediaQuery.of(context).size.width,
        margin: const EdgeInsets.only(left: 10.0 , right: 10.0),
        // color: Colors.amber,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              photoUrl != null ?
              CircleAvatar(
                backgroundImage: NetworkImage(photoUrl),
                radius: 40.0,
              )
              :
              CircleAvatar(
                backgroundColor: Colors.pink.shade100,
                radius: 40.0,
              ),
              Container(
                // color: Colors.cyan,
                height: 100.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text(
                        emailId as String,
                        style: GoogleFonts.caveat(
                          textStyle: const TextStyle(
                            letterSpacing: 2.0,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold
                          )
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            width: 200.0,
                            height: 40.0,
                            child: TextFormField(
                              controller: _editingController,
                              enabled: _isEditingText,
                              style: GoogleFonts.caveat(
                                textStyle: const TextStyle(
                                  fontSize: 20.0
                                )
                              ),
                              // textAlignVertical: TextAlignVertical.center,
                              decoration: const InputDecoration(
                                contentPadding: EdgeInsets.only(top: 10 , left: 10.0),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)
                                  ),
                                ), 
                              ),
                            ),
                          ),
                          !_isEditingText ? 
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  _isEditingText = true;
                                });
                              },
                              icon: const Icon(Icons.edit)
                            )
                            :
                            IconButton(
                              onPressed: () async {
                                await FireStoreUserHelper.updateUserDisplayName(user , _editingController.text);
                                setState(() {
                                  _isEditingText = false;
                                });
                              },
                              icon: const Icon(Icons.done , color: Colors.green),
                            )
                        ],
                      )
                    ]
                  ),
                ),
              )
            ],
          ),
        ),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return 
      Scaffold(
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white10,
                Colors.white38,
                // Colors.white54,
                Colors.cyan.shade400
              ]
            )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FutureBuilder(
                future: getCurrentUserFromFireBase(),
                builder: (BuildContext context , AsyncSnapshot<FireStoreUserHelper?> snapshot) {
                  if(snapshot.connectionState == ConnectionState.done) {  
                    _editingController = TextEditingController(text: snapshot.data!.displayName);
                    return profileAreaBuilder(snapshot.data!.displayName, snapshot.data!.emailId, snapshot.data!.photoUrl);
                  } 
                  return Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10.0),
                      height: 30.0,
                      width: 30.0,
                      child: const CircularProgressIndicator(
                        color: Colors.black,
                      ),
                    )
                  );
                },
              ),
              const Divider(
                height: 20.0,
                indent: 20.0,
                endIndent: 20.0,
                color: Colors.black87,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  margin: const EdgeInsets.only(left: 10.0 , right: 10.0),
                  // color: Colors.amber,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[

                      ],
                    )
                  ),
                )
              )
            ],
          )
        )
      );
  }

}
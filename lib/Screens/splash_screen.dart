import 'dart:async';

import 'package:be_isear/Authentication/firebase_authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreen createState() => _SplashScreen();
}

class _SplashScreen extends State<SplashScreen> {

  Future<FirebaseApp> _initialiseFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  void getRoute() {
    // Get the Current logged in User
    User? user = FirebaseAuth.instance.currentUser;
    String routeName = "";
    //Set the RouteName Accordingly
    routeName = user == null ? "/login" : "/userScreen";
    Timer(
      // After 3 seconds, Navigate the User to Login / UserScreen, Replacing all routes in the stack
        const Duration(seconds: 3),
        () => {
          Navigator.pushReplacementNamed(context, routeName)
        }
      );
  }

  @override
  void initState() {
    // Initialise Firebase for this App.
    _initialiseFirebase().then((result) {
      getRoute(); // Get the Next Route after Splash Screen.
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // backgroundColor: Colors.green,
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.cyan.shade400,
                Colors.white,
                Colors.white24,
                Colors.cyan.shade300,
                Colors.cyan.shade700
              ]
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 250.0,
                    width: 250.0,
                    child: Image.asset('Assets/splash.png'),
                  ), 
                  Text(
                    'ISEAR',
                    style: GoogleFonts.caveat(
                      textStyle: const TextStyle(
                        fontSize: 35.0,
                        letterSpacing: 3.0,
                        color: Colors.black
                      )
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

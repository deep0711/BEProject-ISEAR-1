import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

  @override
  void initState() {
    _initialiseFirebase().then((result) {
      Timer(
        const Duration(seconds: 3),
        () => {
          Navigator.pushNamed(context, '/login')
        }
      );
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.green,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 250.0,
                width: 250.0,
                child: Image.asset('Assets/splash.png'),
              ),
              const Text(
                'ISEAR',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                  letterSpacing: 2.0,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 50),
                child: CircularProgressIndicator(
                  color: Colors.black,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

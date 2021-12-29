import 'package:be_isear/Screens/Login/login_user.dart';
import 'package:be_isear/Screens/Register/regiater_user.dart';
import 'package:be_isear/Screens/splash_screen.dart';
import 'package:be_isear/User/user_main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          primaryColor: Colors.white, scaffoldBackgroundColor: Colors.white),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginUser(),
        '/register': (context) => const RegisterUser(),
        '/userScreen': (context) => const UserMainScreen(),
      },
    );
  }
}

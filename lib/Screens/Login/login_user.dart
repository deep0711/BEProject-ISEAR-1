// import 'dart:html';

import 'package:be_isear/Authentication/firebase_authentication.dart';
import 'package:be_isear/FireStore/firestore_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginUser extends StatefulWidget {
  const LoginUser({Key? key}) : super(key: key);

  @override
  _LoginUser createState() => _LoginUser();
}

class _LoginUser extends State<LoginUser> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool hideEnteredPassword = true;
  bool isLoggingIn = false; // FeedBack to User while Logging In

  @override
  // ignore: must_call_super
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //Login user with his / her Email Id
  Future<String> loginUser(
      {required String email, required String password}) async {
    //using Static Function of FireBaseAuthHelper Class
    final String status = await FireBaseAuthHelper.signInUsingEmailPassword(
        email: email, password: password);
    setState(() {
      isLoggingIn = false;
    });
    return status;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            body: SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.cyan.shade100])),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Center(
                child: SizedBox(
                  width: 200,
                  height: 150,
                  child: Image.asset('Assets/splash.png'),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    // ignore: prefer_const_literals_to_create_immutables
                    boxShadow: [
                      const BoxShadow(
                        color: Colors.grey,
                        offset: Offset(0.0, 1.0), //(x,y)
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                        // color: Colors.green,
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(
                          height: 45.0,
                          width: 350.0,
                          child: TextField(
                            controller: _emailController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                              ),
                              focusColor: Colors.black,
                              labelText: 'Email',
                              labelStyle: GoogleFonts.caveat(
                                  textStyle: const TextStyle(
                                      fontSize: 15.0,
                                      letterSpacing: 2,
                                      color: Colors.black)),
                              prefixIcon: const Icon(Icons.email),
                            ),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        SizedBox(
                          height: 45.0,
                          width: 350.0,
                          child: TextField(
                            controller: _passwordController,
                            decoration: InputDecoration(
                              border: const OutlineInputBorder(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(10.0),
                                    bottomRight: Radius.circular(10.0)),
                              ),
                              focusColor: Colors.black,
                              labelText: 'Password',
                              labelStyle: GoogleFonts.caveat(
                                  textStyle: const TextStyle(
                                      fontSize: 15.0,
                                      letterSpacing: 2,
                                      color: Colors.black)),
                              prefixIcon: const Icon(Icons.lock),
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    hideEnteredPassword = !hideEnteredPassword;
                                  });
                                },
                                icon: const Icon(Icons.remove_red_eye_outlined)
                              )
                            ),
                            obscureText: hideEnteredPassword,
                            keyboardType: TextInputType.visiblePassword,
                          ),
                        ),
                        Container(
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {},
                              child: Text(
                                'Forget Passoerd',
                                style: GoogleFonts.caveat(
                                    textStyle: const TextStyle(
                                        color: Colors.blue,
                                        fontSize: 15.0,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                        isLoggingIn
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                            : Container(
                                height: 40,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  color: Colors.blue,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: ElevatedButton(
                                  style:
                                      ElevatedButton.styleFrom(elevation: 2.0),
                                  onPressed: () async {
                                    setState(() {
                                      isLoggingIn = true;
                                    });
                                    //Call LoginUser Function for Signing In the User
                                    String loginStatus = await loginUser(
                                        email: _emailController.text,
                                        password: _passwordController.text);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(content: Text(loginStatus)));
                                    if (loginStatus ==
                                        'Successfully Signed In') {
                                      Navigator.pushNamedAndRemoveUntil(context,
                                          '/userScreen', (route) => false);
                                    }
                                  },
                                  child: Text('Login',
                                      style: GoogleFonts.caveat(
                                          textStyle: const TextStyle(
                                              fontSize: 24.0,
                                              letterSpacing: 2.0,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold))),
                                ),
                              ),
                        const SizedBox(height: 20),
                        const Divider(
                          height: 10.0,
                          indent: 40.0,
                          endIndent: 40.0,
                          thickness: 2,
                          color: Colors.black,
                        ),
                        const SizedBox(height: 20),
                        Container(
                          color: Colors.grey.shade200,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Image.asset(
                                'Assets/google.png',
                                width: 50,
                                height: 50.0,
                              ),
                              TextButton(
                                onPressed: () async {
                                  //Login User using Google
                                  User? user =
                                      await FireBaseAuthHelper.signInWithGoogle(
                                          context: context);
                                  if (user != null) {
                                    //When User is Registered to the Data base
                                    FireStoreUserHelper.addUserToDataBase(user);
                                    //If Success then Take User to UserScreen after Removing All Previous Routes from the Stack
                                    Navigator.pushReplacementNamed(
                                        context, '/userScreen');
                                  }
                                },
                                child: Text(
                                  'Sign In With Google',
                                  style: GoogleFonts.caveat(
                                      textStyle: const TextStyle(
                                          letterSpacing: 2.0,
                                          fontSize: 20.0,
                                          color: Colors.black)),
                                ),
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Container(
                            // color: Colors.amber,
                            child: TextButton(
                          onPressed: () {
                            //Take user to Register Screen
                            Navigator.pushNamed(context, '/register');
                          },
                          child: Text(
                            'New Here? Register!',
                            style: GoogleFonts.caveat(
                                textStyle: const TextStyle(
                                    fontSize: 15.0,
                                    color: Colors.black,
                                    letterSpacing: 2.0)),
                          ),
                        ))
                      ],
                    )),
                  )),
            )
          ],
        ),
      ),
    )));
  }
}
// child: Column(
//                 children: <Widget>[
//                   Padding(
//                     padding: const EdgeInsets.only(top: 60),
//                     child: Center(
//                       child: SizedBox(
//                         width: 200,
//                         height: 150,
//                         child: Image.asset('Assets/splash.png'),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 15),
//                     child: TextField(
//                       controller: _emailController,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Email',
//                         prefixIcon: Icon(Icons.email_outlined)
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0, bottom: 0),
//                     child: TextField(
//                       controller: _passwordController,
//                       obscureText: true,
//                       decoration: const InputDecoration(
//                         border: OutlineInputBorder(),
//                         labelText: 'Password',
//                         prefixIcon: Icon(Icons.lock)
//                       ),
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () {},
//                     child: const Text(
//                       'Forget Password',
//                       style: TextStyle(color: Colors.blue, fontSize: 15, letterSpacing: 2.0)
//                     ),
//                   ),
//                   Container(
//                     height: 50,
//                     width: 250,
//                     decoration: BoxDecoration(
//                       color: Colors.blue,
//                       borderRadius: BorderRadius.circular(20),
//                     ),
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(elevation: 2.0),
//                       onPressed: () async { 
//                         //Call LoginUser Function for Signing In the User
//                         loginUser(email: _emailController.text, password: _passwordController.text, context: context);
//                       },
//                       child: const Text(
//                         'Login',
//                         style: TextStyle(color: Colors.white, fontSize: 25)
//                       ),
//                     ),
//                   ),
//                   const Divider(
//                     height: 20.0,
//                     indent: 20.0,
//                     endIndent: 20.0,
//                     thickness: 2,
//                   ),
//                   Container(  
//                     color: Colors.grey.shade100,
//                     width: 350,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       children: <Widget>[
//                         Image.asset(
//                           'Assets/google.png',
//                           width: 50,
//                           height: 50.0,
//                         ),
//                         TextButton(
//                           onPressed: () async {
//                             //Login User using Google
//                             User? user = await FireBaseAuthHelper.signInWithGoogle(context: context);
//                             if(user != null) {
//                               //If Success then Take User to UserScreen after Removing All Previous Routes from the Stack
//                               Navigator.pushReplacementNamed(context, '/userScreen');
//                             }
                              
//                           },
//                           child: Text(
//                             'Sign In With Google',
//                             style: GoogleFonts.caveat(
//                               textStyle: const TextStyle(
//                                 letterSpacing: 2.0,
//                                 fontSize: 20.0,
//                                 color: Colors.black
//                               )
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   ),
//                   const SizedBox(
//                     height: 50,
//                   ),
//                   TextButton(
//                     onPressed: () {
//                       //Take user to Register Screen
//                       Navigator.pushNamed(context, '/register');
//                     }, 
//                     child: const Text(
//                       'New User? Create Account!!',
//                       style: TextStyle(
//                         color: Colors.black,
//                         letterSpacing: 2.0,
//                       ),
//                     )
//                   ),
//                 ],
//               )
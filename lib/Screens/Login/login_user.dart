import 'package:be_isear/Authentication/firebase_authentication.dart';
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

  @override
  // ignore: must_call_super
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  //Login user with his / her Email Id
  void loginUser(String email , String password) async {
    //using Static Function of FireBaseAuthHelper Class
    User? user = await FireBaseAuthHelper.signInUsingEmailPassword(
      email: email 
      password: password);

    if(user != null) {
      //If user is Successfully SignedIn
      //Remove all Routes in the Stack and take him to User Screen
      Navigator.pushReplacementNamed(context , '/userScreen');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
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
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: TextField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
                        prefixIcon: Icon(Icons.email_outlined)
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0, right: 15.0, left: 15.0, bottom: 0),
                    child: TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock)
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'Forget Password',
                      style: TextStyle(color: Colors.blue, fontSize: 15, letterSpacing: 2.0)
                    ),
                  ),
                  Container(
                    height: 50,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(elevation: 2.0),
                      onPressed: () async { 
                        //Call LoginUser Function for Signing In the User
                        loginUser(_emailController.text, _passwordController.text);
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(color: Colors.white, fontSize: 25)
                      ),
                    ),
                  ),
                  const Divider(
                    height: 20.0,
                    indent: 20.0,
                    endIndent: 20.0,
                    thickness: 2,
                  ),
                  Container(  
                    color: Colors.grey.shade100,
                    width: 350,
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
                            User? user = await FireBaseAuthHelper.signInWithGoogle(context: context);
                            if(user != null) {
                              //If Success then Take User to UserScreen after Removing All Previous Routes from the Stack
                              Navigator.pushReplacementNamed(context, '/userScreen');
                            }
                              
                          },
                          child: Text(
                            'Sign In With Google',
                            style: GoogleFonts.caveat(
                              textStyle: const TextStyle(
                                letterSpacing: 2.0,
                                fontSize: 20.0,
                                color: Colors.black
                              )
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  TextButton(
                    onPressed: () {
                      //Take user to Register Screen
                      Navigator.pushNamed(context, '/register');
                    }, 
                    child: const Text(
                      'New User? Create Account!!',
                      style: TextStyle(
                        color: Colors.black,
                        letterSpacing: 2.0,
                      ),
                    )
                  ),
                ],
              ),
            )
          )
        );
  }
}

import 'package:be_isear/Authentication/firebase_authentication.dart';
import 'package:be_isear/FireStore/firestore_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({Key? key}) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isSubmitting = false;

  Future<User?> signInUserWithEmailPassword(
      {required BuildContext context}) async {
    User? user;
    if (_formKey.currentState!.validate()) {
      user = await FireBaseAuthHelper.registerUsingEmailPassword(
          email: _emailController.text,
          password: _passwordController.text) as User;
    }
    setState(() {
      isSubmitting = false;
    });
    return user;
  }

  @override
  // ignore: must_call_super
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Register Here!',
          style: GoogleFonts.caveat(
              textStyle:
                  const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold)),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.blue, Colors.cyan.shade100])),
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.asset(
                'Assets/namaste.png',
                width: 200,
                height: 200,
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 1.0),
                          blurRadius: 2.0)
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        SizedBox(
                          height: 45.0,
                          width: 350,
                          child: TextFormField(
                            controller: _emailController,
                            autofocus: true,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.emailAddress,
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
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please Enter a Email';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 45.0,
                          width: 350,
                          child: TextFormField(
                            controller: _passwordController,
                            obscureText: true,
                            cursorColor: Colors.black,
                            keyboardType: TextInputType.visiblePassword,
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
                                prefixIcon: const Icon(Icons.lock)),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Empty Field';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 30),
                        !isSubmitting
                            ? ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    isSubmitting = true;
                                  });
                                  User? user =
                                      await signInUserWithEmailPassword(
                                          context: context);
                                  if (user != null) {
                                    await FireStoreUserHelper.addUserToDataBase(
                                        user);
                                    Navigator.pushReplacementNamed(
                                        context, '/login');
                                  }
                                },
                                child: Text('Sign Up',
                                    style: GoogleFonts.caveat(
                                        textStyle: const TextStyle(
                                            letterSpacing: 2.0,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold))),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: Colors.black,
                                ),
                              )
                      ],
                    ),
                  ),
                ),
              ),
              const Divider(
                height: 20,
                thickness: 2,
                indent: 20.0,
                endIndent: 20.0,
              ),
              Center(
                child: Text('Welcome to ISEAR',
                    style: GoogleFonts.caveat(
                        textStyle: const TextStyle(
                            letterSpacing: 2.0,
                            fontSize: 25,
                            fontWeight: FontWeight.bold))),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:be_isear/Authentication/firebase_authentication.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterUser extends StatefulWidget {
  const RegisterUser({ Key? key }) : super(key: key);

  @override
  _RegisterUserState createState() => _RegisterUserState();
}

class _RegisterUserState extends State<RegisterUser> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void signInUserWithEmailPassword({required BuildContext context}) {
    if(_formKey.currentState!.validate()) {
      FireBaseAuthHelper.registerUsingEmailPassword(
        email: _emailController.text,
        password: _passwordController.text)
        .then((value) => {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Succesfully Signed In'))
          )
        })
        .catchError((error) => {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Something Went Wrong!'))
          )
        });
    }
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
            textStyle: const TextStyle(
              fontSize: 25.0,
              fontWeight: FontWeight.bold
            )
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        color: Colors.white,
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
                decoration: const BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0.0, 1.0),
                      blurRadius: 2.0
                    )
                  ]
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          controller: _emailController,
                          autofocus: true,
                          cursorColor: Colors.black,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            labelText: 'Email ID',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email)
                          ),
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return 'Please Enter a Email';
                            } 
                            return null;
                          },
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          cursorColor: Colors.black,
                          keyboardType: const TextInputType.numberWithOptions(),
                          decoration: const InputDecoration(
                            labelText: 'Password',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.lock_outline)
                          ),
                          validator: (value) {
                            if(value == null || value.isEmpty) {
                              return 'Empty Filed';
                            }
                            return null;
                          },
                        ),
                        const SizedBox( height: 30),
                        ElevatedButton(
                          onPressed: () {
                            signInUserWithEmailPassword(context: context);
                          },
                          child: const Text(
                            'Sign Up',
                            style: TextStyle(
                              letterSpacing: 2.0,
                              fontSize: 15
                            ),
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
                child: Text(
                  'Welcome to ISEAR',
                  style: GoogleFonts.caveat(
                    textStyle: const TextStyle(
                      letterSpacing: 2.0,
                      fontSize: 25,
                      fontWeight: FontWeight.bold
                    )
                  )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
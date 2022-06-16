import 'package:close_contact/screens/forget_password.dart';
import 'package:close_contact/widgets/bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:close_contact/authentication/fire_auth.dart';
import 'package:close_contact/authentication/validator.dart';
import 'package:close_contact/screens/home.dart';
import 'package:close_contact/screens/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber[50],
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Close Contact',
                    style: TextStyle(
                        color: Colors.brown,
                        fontFamily: 'Murray Hill',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                        fontSize: 60),
                  )),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  )),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'NUS Email',
                  ),
                  validator: (value) => Validator.validateEmail(email: value),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: TextFormField(
                  obscureText: true,
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (value) =>
                      Validator.validatePassword(password: value),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ForgetPassword()),
                  );
                },
                child: const Text(
                  'Forgot Password',
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      User? user = await FireAuth.signInUsingEmailPassword(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      if (user != null) {
                        // disabled email verification for now,
                        //if (!user.emailVerified) {
                        if (false) {
                          showAlertDialog(context);
                          await user.sendEmailVerification();
                        } else {
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => BotNavBar(user)),
                          );
                        }
                      }
                    }
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text('Don\'t have an account?'),
                  TextButton(
                    child: const Text(
                      'Register',
                      style: TextStyle(fontSize: 20),
                    ),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => Register()),
                      );
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // Create button
    Widget okButton = TextButton(
      child: const Text("OK"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // Create AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Email Verification"),
      content: const Text("Please verify your email before proceeding."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}

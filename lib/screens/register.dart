import 'package:close_contact/screens/login.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:close_contact/authentication/fire_auth.dart';
import 'package:close_contact/authentication/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Register extends StatelessWidget {
  Register({Key? key}) : super(key: key);
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _password1Controller = TextEditingController();
  final TextEditingController _password2Controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
                ),
              ),
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'Register',
                    style: TextStyle(fontSize: 20),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
                child: TextFormField(
                  key: Key("name"),
                  controller: _nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Name',
                  ),
                  validator: (value) => Validator.validateName(name: value),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextFormField(
                  key: Key("email"),
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'NUS Email',
                  ),
                  validator: (value) => Validator.validateEmail(email: value),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: TextFormField(
                  key: Key("password"),
                  obscureText: true,
                  controller: _password1Controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  validator: (value) =>
                      Validator.validatePassword(password: value),
                ),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
                child: TextFormField(
                  key: Key("confirmPassword"),
                  obscureText: true,
                  controller: _password2Controller,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm password',
                  ),
                  validator: (value) => Validator.validatePasswordSame(
                      password1: _password1Controller.text, password2: value),
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Register'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        User? user = await FireAuth.registerUsingEmailPassword(
                          name: _nameController.text,
                          email: _emailController.text,
                          password: _password1Controller.text,
                        );
                        if (user != null) {
                          user.sendEmailVerification();
                          //add user into Cloud Firestore
                          CollectionReference users = await db.collection('users');
                          await users
                              .doc(user.uid)
                              .set({
                                "userid": user.uid,
                                "Name": _nameController.text,
                                "Email": _emailController.text,
                              })
                              .then((value) => showDialog(
                                  context: _scaffoldKey.currentContext!,
                                  builder: (context) => AlertDialog(
                                      content:
                                          Text("Email verification sent!"))))
                              .catchError((error) => showDialog(
                                  context: _scaffoldKey.currentContext!,
                                  builder: (context) => AlertDialog(
                                      content: Text(
                                          'Failed to add user : $error'))));
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(builder: (context) => LogIn()),
                          );
                        }
                      } catch (SignUpError) {
                        showDialog(
                            context: _scaffoldKey.currentContext!,
                            builder: (dialogContext) => AlertDialog(
                                content: Text(
                                    "Failed to add user: Account already exists!")));
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

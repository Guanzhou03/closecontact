import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:close_contact/authentication/fire_auth.dart';
import 'package:close_contact/authentication/validator.dart';
import 'package:close_contact/screens/home.dart';
import 'package:close_contact/screens/register.dart';

class SignIn extends StatelessWidget {
  SignIn({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      //backgroundColor: Colors.amber[50],
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
                        fontSize: 70),
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
                  //forgot password screen
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
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(builder: (context) => Home(user)),
                        );
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
}

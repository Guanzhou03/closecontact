import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:close_contact/authentication/validator.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);
  var _emailController = TextEditingController();
  final _auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();

  // Future<AuthCredential> resetPassword({required String email}) async {
  //   await _auth
  //       .sendPasswordResetEmail(email: email)
  //       .then((value) => _status = AuthCredential)
  //       .catchError(
  //           (e) => _status = AuthExceptionHandler.handleAuthException(e));
  //   return _status;
  // }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formkey,
      child: Scaffold(
        backgroundColor: Colors.amber[50],
        body: Column(children: [
          Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.fromLTRB(10, 50, 10, 90),
              child: const Text(
                'Close Contact',
                style: TextStyle(
                    color: Colors.brown,
                    fontFamily: 'Murray Hill',
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w900,
                    fontSize: 60),
              )),
          Icon(Icons.lock_outline, size: 65, color: Colors.red),
          Container(
            alignment: Alignment.center,
            child: Text(
              'Reset Password',
              style: TextStyle(
                  color: Colors.brown,
                  fontFamily: 'Montserrat',
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w900,
                  fontSize: 30),
            ),
          ),
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
          ElevatedButton(
            onPressed: () async {
              if (_formkey.currentState!.validate()) {
                try {
                  await FirebaseAuth.instance.sendPasswordResetEmail(
                      email: _emailController.text.trim());
                  Navigator.of(context).pop();
                } catch (e) {
                  print(e);
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      content: Text("There is no account with this email."),
                    ),
                  );
                }

                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    content: Text(
                        "Password reset email has been sent! Follow the instructions in your email to reset your password."),
                  ),
                );
              }
            },
            child: const Text("Reset Password"),
            style: ElevatedButton.styleFrom(
              primary: Colors.blueAccent,
              minimumSize: Size(350, 50),
            ),
          )
        ]),
      ),
    );
  }
}

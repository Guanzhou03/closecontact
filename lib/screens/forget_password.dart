import 'package:flutter/material.dart';
import 'package:close_contact/authentication/validator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ForgetPassword extends StatelessWidget {
  ForgetPassword({Key? key}) : super(key: key);

  FirebaseFirestore db = FirebaseFirestore.instance;
  var _emailController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.amber[50],
        body: Column(
            children: [
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
        ) ,Container(
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
            ElevatedButton(onPressed: ()
            {
              //backend email verification
            },
                child: const Text("Reset Password"),
            style: ElevatedButton.styleFrom(primary: Colors.blueAccent, minimumSize: Size(350, 50)))])
    );
  }
}

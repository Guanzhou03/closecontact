import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_complete_guide/screens/signin.dart';

class LogIn extends StatelessWidget {
  const LogIn({Key? key}) : super(key: key);

  //a method that initializes Firebase
  Future<FirebaseApp> _initializeFirebase() async {
    FirebaseApp firebaseApp = await Firebase.initializeApp();
    return firebaseApp;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initializeFirebase(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return SignIn();
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        });
  }
}

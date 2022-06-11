import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InfoGetter {
  static String _bio = "Add a bio";
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static String bioGetter({required User? user}) {
    if (user == null) {
      return _bio;
    }
    db.collection("users").doc(user.uid).get().then((value) => {
          if (value.exists)
            {
              _bio = value.data()!["bio"] as String,
            }
        });
    print(_bio);
    return _bio;
  }
}

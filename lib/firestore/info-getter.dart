import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InfoGetter {
  static Future<String> bioGetter({required User? user}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String _bio = "Add a bio";
    if (user == null) {
      return Future(() => _bio);
    }

    await db.collection("users").doc(user.uid).get().then((value) => {
          if (value.exists)
            {
              _bio = value.data()!["bio"] as String,
            }
        });
    return _bio;
  }

  static Future<String> facultyGetter({required User? user}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String _faculty = "Please choose a faculty";
    if (user == null) {
      return Future(() => _faculty);
    }

    await db.collection("users").doc(user.uid).get().then((value) => {
          if (value.exists)
            {
              _faculty = value.data()!["faculty"] as String,
            }
        });
    return _faculty;
  }

  static Future<String> yearGetter({required User? user}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String _year = "Please choose your year of study";
    if (user == null) {
      return Future(() => _year);
    }

    await db.collection("users").doc(user.uid).get().then((value) => {
          if (value.exists)
            {
              _year = value.data()!["year"] as String,
            }
        });
    return _year;
  }

  static Future<String> activitiesGetter({required User? user}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String _activities = "";
    if (user == null) {
      return Future(() => _activities);
    }
    await db.collection("users").doc(user.uid).get().then((value) => {
          if (value.exists)
            {
              print("hi 2"),
              //print(value.data()!["activities"]),
              _activities = value.data()!["activities"] as String,
              print("hi 3"),
            }
        });
    return _activities;
  }
}

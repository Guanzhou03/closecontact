import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class InfoGetter {
  static Future<String> bioGetter({required String userID}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String _bio = "Add a bio";
    if (userID == "") {
      return Future(() => _bio);
    }
    await db.collection("users").doc(userID).get().then((value) => {
          if (value.exists)
            {
              _bio = value.data()!["bio"] as String,
            }
        });
    return _bio;
  }
  static Future<String> imageURLGetter({required String userID}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String _imageURL = "";
    if (userID == "") {
      return Future(() => _imageURL);
    }
    await db.collection("users").doc(userID).get().then((value) => {
      if (value.exists)
        {
          _imageURL = value.data()!["imageURL"] as String,
        }
    });
    return _imageURL;
  }

  static Future<String> facultyGetter({required String userID}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String _faculty = "Please choose a faculty";
    if (userID == "") {
      return Future(() => _faculty);
    }

    await db.collection("users").doc(userID).get().then((value) => {
          if (value.exists)
            {
              _faculty = value.data()!["faculty"] as String,
            }
        });
    return _faculty;
  }

  static Future<String> yearGetter({required String userID}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String _year = "Please choose your year of study";
    if (userID == "") {
      return Future(() => _year);
    }

    await db.collection("users").doc(userID).get().then((value) => {
          if (value.exists)
            {
              _year = value.data()!["year"] as String,
            }
        });
    return _year;
  }

  static Future<String> activitiesGetter({required String userID}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String _activities = "";
    if (userID == "") {
      return Future(() => _activities);
    }
    await db.collection("users").doc(userID).get().then((value) => {
          if (value.exists)
            {
              _activities = value.data()!["activities"] as String,
            }
        });
    return _activities;
  }
}

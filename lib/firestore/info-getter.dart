import 'dart:ffi';

import 'package:close_contact/screens/profile.dart';
import 'package:close_contact/widgets/profile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:collection/collection.dart';

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
              _bio = value.data()?["bio"] as String,
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
              _activities = value.data()!["activities"] as String,
            }
        });
    return _activities;
  }

  static Future<Iterable<Map<String, dynamic>>> getValidUsers() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var temp = await db
        .collection("users")
        .orderBy("Name")
        .orderBy("activities")
        .orderBy("imageURL")
        .get()
        .then((value) => value.docs)
        .then((value) => value.map((e) => e.data()));
    return temp;
  }

  static Future<List<Profile>> cardStackCreator({required user}) async {
    var temp = await getValidUsers();
    var result = await temp.map((e) {
      var uid = e["userid"];
      var name = e["Name"];
      var interests = e["activities"];
      var imageURL = e["imageURL"];
      late String photoURL;
      if (uid == user.uid) return null;
      if (imageURL == null) {
        photoURL = 'https://picsum.photos/id/237/5000/5000';
      } else {
        photoURL = imageURL;
      }
      try {
        print("photo is: " + photoURL);
        return Profile(name: name, interests: interests, imageURL: photoURL);
      } catch (e) {
        return Profile(
            name: name,
            interests: 'ERROR',
            imageURL: 'https://picsum.photos/id/237/5000/5000');
      }
    }).toList();
    return result.whereNotNull().toList();
  }

  static Future<List<String>> userIdListGetter({required user}) async {
    var temp = await getValidUsers();
    var result = temp.map((e) {
      var userid = e["userid"];
      if (user.uid == userid) {
        return null;
      }
      return e["userid"].toString();
    }).toList();
    return result.whereNotNull().toList();
  }

  static Future<List<String>?> currIncoming({required userid}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var result = await db
        .collection("users")
        .doc(userid)
        .collection("requests")
        .doc("incoming")
        .get()
        .then((value) => value.exists ? value.get("incoming") : null);
    return result == null ? null : List<String>.from(result);
  }
}

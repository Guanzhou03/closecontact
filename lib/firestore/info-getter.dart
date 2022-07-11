import 'package:close_contact/firestore/pref-filters.dart';
import 'package:close_contact/widgets/profile_card.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

class InfoGetter {
  static Future<List<String>> currIncoming({required userid}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var result = await db
        .collection("users")
        .doc(userid)
        .collection("requests")
        .doc("incoming")
        .get()
        .then((value) => value.exists ? value.get("incoming") : null);
    return result == null ? [] : List<String>.from(result);
  }

  static Future<String> bioGetter({required String userID}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String _bio = "Add a bio";
    if (userID == "") {
      return Future(() => _bio);
    }
    await db.collection("users").doc(userID).get().then((value) => {
          if (value.exists)
            {
              _bio = value.data()?["bio"] as String,
            }
        });
    return _bio;
  }

  static Future<String> areaGetter({required String userID}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String _area = "Add your location";
    if (userID == "") {
      return Future(() => _area);
    }
    await db.collection("users").doc(userID).get().then((value) => {
          if (value.exists)
            {
              _area = value.data()?["area"] as String,
            }
        });
    return _area;
  }

  static Future<String> genderGetter({required String userID}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String _area = "Add your gender";
    if (userID == "") {
      return Future(() => _area);
    }
    await db.collection("users").doc(userID).get().then((value) => {
          if (value.exists)
            {
              _area = value.data()?["gender"] as String,
            }
        });
    return _area;
  }

  static Future<String> nameGetter({required String userID}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    String _name = "name";
    if (userID == "") {
      return Future(() => _name);
    }
    await db.collection("users").doc(userID).get().then((value) => {
          if (value.exists)
            {
              _name = value.data()!["Name"] as String,
            }
        });
    return _name;
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
          if (value.exists) {_faculty = value.data()!["faculty"] as String}
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
    var prefList = await prefGetter(userid: user.uid);
    List<bool> genderList = List<bool>.from(prefList["gender"]);
    List<bool> facultyList = List<bool>.from(prefList["faculty"]);
    List<bool> yearList = List<bool>.from(prefList["year"]);
    List<bool> areaList = List<bool>.from(prefList["area"]);
    List<bool> interestList = List<bool>.from(prefList["interests"]);
    var temp = await getValidUsers();
    var result = await temp.map((e) {
      var uid = e["userid"];
      var name = e["Name"];
      var interests = e["activities"];
      var imageURL = e["imageURL"];
      late String photoURL;
      if (uid == user.uid) return null;
      if (imageURL == " ") {
        return null;
      } else {
        photoURL = imageURL;
      }
      try {
        if (prefList.isNotEmpty) {
          if (PrefFilters.filterGender(e["gender"].toString(), genderList)) {
            return Profile(
                name: name, interests: interests, imageURL: photoURL);
          }
          return null;
        }
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
    var prefList = await prefGetter(userid: user.uid);
    List<bool> genderList = List<bool>.from(prefList["gender"]);
    List<bool> facultyList = List<bool>.from(prefList["faculty"]);
    List<bool> yearList = List<bool>.from(prefList["year"]);
    List<bool> areaList = List<bool>.from(prefList["area"]);
    List<bool> interestList = List<bool>.from(prefList["interests"]);
    var temp = await getValidUsers();
    var result = temp.map((e) {
      var userid = e["userid"];
      var imageURL = e["imageURL"];
      if (user.uid == userid) {
        return null;
      }
      if (imageURL == " ") {
        return null;
      }
      if (prefList.isNotEmpty) {
        if (PrefFilters.filterGender(e["gender"].toString(), genderList)) {
          return userid.toString();
        }
        return null;
      }
      return e["userid"].toString();
    }).toList();
    return result.whereNotNull().toList();
  }

  static Future<List<String>> currConvoGetter({required userid}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    List<String> _currConvo = [];
    if (userid == "") {
      return Future(() => _currConvo);
    }
    await db.collection("users").doc(userid).get().then((value) => {
          if (value.exists)
            {
              if (value.data()!.containsKey("currConvo"))
                {_currConvo = List<String>.from(value.data()!["currConvo"])}
            }
        });
    return _currConvo;
  }

  static Future<Map<String, dynamic>> prefGetter({required userid}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    Map<String, dynamic> _prefList = {};
    if (userid == "") {
      return Future(() => _prefList);
    }
    await db
        .collection("users")
        .doc(userid)
        .collection("preferences")
        .doc("preferences")
        .get()
        .then((value) {
      if (value.exists) {
        if (value.data() != null) {
          _prefList = value.data()!;
        }
      }
    });
    return _prefList;
  }
}

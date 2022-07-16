import 'package:close_contact/firestore/info-getter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart';

class InfoSetter {
  static Future<void> setCurrConvo(
      {required String userid, required String newConvo}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var temp = await db.collection("users").doc(userid);
    var bool = await temp
        .get()
        .then((value) => value.data()!.containsKey("currConvo"));
    if (!bool) {
      temp.set({
        "currConvo": [newConvo]
      }, SetOptions(merge: true));
    } else {
      List<String> curr = List<String>.from(
          await temp.get().then((value) => value.get("currConvo")));
      if (!curr.contains(newConvo)) curr.add(newConvo);
      temp.update({"currConvo": curr});
    }
  }

  static Future<void> setCurrRequests(
      {required String userid, required String oldRequest}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var ref = await db
        .collection("users")
        .doc(userid)
        .collection("requests")
        .doc("incoming");
    List<String> temp =
        List<String>.from(await ref.get().then((value) => value["incoming"]));
    var result = temp
        .map((e) {
          if (e == oldRequest) {
            return null;
          } else {
            return e;
          }
        })
        .toList()
        .whereNotNull()
        .toList();
    ref.set({"incoming": result}, SetOptions(merge: true));
  }


  static Future<bool> setRoomState(
      {required String roomID}) async {
    bool isBlocked = false;
    String? initiator = "";
    FirebaseFirestore db = FirebaseFirestore.instance;
    var ref = await db
        .collection("rooms")
        .doc(roomID);
    await ref.get().then((value) => {
      if (value.exists)
        {
          isBlocked = value.data()?["isBlocked"] as bool,
          initiator = value.data()?["initiator"] as String
        }
    });
    await ref.set({"isBlocked": isBlocked}, SetOptions(merge: true));
    await ref.set({"initiator": initiator}, SetOptions(merge: true));
    return isBlocked;
  }

  static Future<void> toggleBlockedState(
      {required String roomID, required String initiator}) async {
    bool isBlocked = false;
    FirebaseFirestore db = FirebaseFirestore.instance;
    var ref = await db
        .collection("rooms")
        .doc(roomID);
    await ref.get().then((value) => {
      if (value.exists)
        {
          isBlocked = value.data()?["isBlocked"] as bool
        }
    });
    String blocker = await InfoGetter.blockerGetter(roomID: roomID);
    if (isBlocked && (initiator == blocker|| blocker == "")) {
      await ref.update({"isBlocked": false});
      await ref.set({"initiator": ""}, SetOptions(merge: true));
    }
    else if (!isBlocked && (initiator == blocker|| blocker == "")) {
      await ref.update({"isBlocked": true});
      await ref.set({"initiator": initiator}, SetOptions(merge:true));
      print("blocked");
     }
    }

  static Future<void> setSeenUsers(
      {required String currUser,
      required String userid,
      required List<String> seenUsers}) async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var temp = await db.collection("users").doc(currUser);
    var bool = await temp
        .get()
        .then((value) => value.data()!.containsKey("seenUsers"));
    if (!bool) {
      temp.set({
        "seenUsers": [userid]
      }, SetOptions(merge: true));
    } else {
      seenUsers.add(userid);
      temp.update({"seenUsers": seenUsers});

    }
  }
}

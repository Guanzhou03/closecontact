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
}

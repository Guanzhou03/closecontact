import 'package:close_contact/firestore/info-getter.dart';
import 'package:close_contact/screens/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:user_profile_avatar/user_profile_avatar.dart';

class RecentChatsPage extends StatefulWidget {
  final User user;
  List<String> currConversations = []; //list of userIDS that user is talking to
  RecentChatsPage(this.user, this.currConversations, {Key? key}) : super(key: key);

  @override
  RecentChats createState() => RecentChats(user, currConversations);
}


class RecentChats extends State<RecentChatsPage> {
  final User user;
  List<String> currConversations = []; //list of userIDS that user is talking to
  RecentChats(this.user, this.currConversations);
  List<String> requestedNames = [];
  List<String> requestedImages = [];
  List<String> roomIDs = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

  initialize() async {
    currConversations = await InfoGetter.currConvoGetter(userid: user.uid);
    await currNameSetter(currConversations);
    await currImageSetter(currConversations);
    roomIDs =
        currConversations.map((id) => maptoRoomID(id).toString()).toList();
  }

  Future<String> maptoNames(id) async {
    String name = await InfoGetter.nameGetter(userID: id);
    return name;
  }

  void deleteChat(int index) async {
    String otherUserID = currConversations[index];
    List<String> otherUserCurrConversations = await InfoGetter.currConvoGetter(userid: otherUserID);
    var ref = await db.collection("users");
    DocumentReference reference = db.collection("rooms").doc(maptoRoomID(otherUserID)); //that specific room
    await reference.delete(); //delete that room
    bool res = otherUserCurrConversations.remove(user.uid);
    dynamic res2 = currConversations.removeAt(index);
    await ref.doc(otherUserID).set({"currConvo": otherUserCurrConversations}, SetOptions(merge: true));
    await ref.doc(user.uid).set({"currConvo": currConversations}, SetOptions(merge: true));
    return;
  }

  void showAlertDialog(BuildContext context, int index) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        setState(() {
          deleteChat(index);
        });
      },
    );
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed: () {
        Navigator.of(context, rootNavigator: true).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Delete Chat"),
      content: Text("Are you sure you want to delete this chat?"),
      actions: [
        okButton,
        cancelButton
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Future<void> currNameSetter(List<String> str) async {
    for (String item in str) {
      var temp = await maptoNames(item);
      requestedNames.add(temp);
    }
  }

  Future<String> maptoImage(id) async {
    String url = await InfoGetter.imageURLGetter(userID: id);
    return url;
  }

  Future<void> currImageSetter(List<String> str) async {
    for (String item in str) {
      var temp = await maptoImage(item);
      requestedImages.add(temp);
    }
  }

  String maptoRoomID(id) {
    return user.uid.compareTo(id) > 0 ? user.uid + id : id + user.uid;
  }

  String getUserName(types.User user) =>
      '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();

  @override
  Widget build(BuildContext context) {
    Widget _buildAvatar(index) {
      return UserProfileAvatar(
        avatarUrl: requestedImages[index],
        onAvatarTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => Chat(
                chatRoomId: roomIDs[index],
                me: user.uid,
                other: currConversations[index],
              ),
            ),
          );
        },
        radius: 40,
        isActivityIndicatorSmall: false,
        avatarBorderData: AvatarBorderData(
          borderColor: Colors.white,
          borderWidth: 5.0,
        ),
      );
    }

    return FutureBuilder(
        future: initialize(),
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Size size = MediaQuery.of(context).size;
            return SizedBox(
                height: size.height,
                width: size.height,
                child: Scaffold(
                    body: ListView.builder(
                  itemCount: currConversations.length,
                  itemBuilder: (context, index) {
                    //final room = snapshot.data![index];
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onLongPress:() {
                          showAlertDialog(context, index);
                        },
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => Chat(
                              chatRoomId: roomIDs[index],
                              me: user.uid,
                              other: currConversations[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Row(
                          children: [
                            _buildAvatar(index),
                            Text(requestedNames[index]),
                          ],
                        ),
                      ),
                    );
                  },
                )));
          } else {
            return Text("error");
          }
        }));
  }
}

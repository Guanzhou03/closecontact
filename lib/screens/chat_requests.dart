import 'package:close_contact/screens/chats_home.dart';
import 'package:close_contact/screens/profile_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:close_contact/widgets/card_stack.dart';
import 'package:close_contact/widgets/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';
import 'package:close_contact/firestore/info-getter.dart';

class ChatRequestPage extends StatefulWidget {
  User user;
  ChatRequestPage(this.user, {Key? key}) : super(key: key);

  @override
  State<ChatRequestPage> createState() => ChatRequest(user);
}

class ChatRequest extends State<ChatRequestPage> {
  final User user;
  ChatRequest(this.user);
  String imageUrl = " ";
  List<String> requestedUsers = ["user1", "user2", "user3", "user4"];
  List<String> requestedNames = [];
  List<String> requestedImages = [];
  List<String> requestedUID = [];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  initialize() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    var temp = await db
        .collection("users")
        .get()
        .then((value) => value.docs)
        .then((value) => value.map((e) => e.data()));
    requestedUsers = temp.map((x) => x["userid"].toString()).toList();
    requestedNames = temp.map((x) => x["Name"].toString()).toList();
    requestedImages = temp.map((x) => x["imageURL"].toString()).toList();
    requestedUID = temp.map((x) => x["userid"].toString()).toList();
  }

  void removal(index) {
    requestedUsers.removeAt(index);
    requestedUID.removeAt(index);
    requestedImages.removeAt(index);
  }

  Widget chatRequestBuilder(index, context) {
    var result = requestedNames[index];
    return Row(children: [
      Column(children: [
        UserProfileAvatar(
          avatarUrl: requestedImages[index] == null
              ? 'https://picsum.photos/id/237/5000/5000'
              : requestedImages[index],
          onAvatarTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfileInfo(requestedUID[index])),
            );
          },
          avatarSplashColor: Colors.purple,
          radius: 50,
          isActivityIndicatorSmall: false,
          avatarBorderData: AvatarBorderData(
            borderColor: Colors.white,
            borderWidth: 5.0,
          ),
        ),
      ]),
      Text("$result")
    ],
    );
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<String>> requestedUsersNotifier = ValueNotifier(requestedUsers);
    key: _scaffoldKey;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(leading: BackButton(onPressed:() => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ChatsHome(user)),
      )),
          title: const Text("Chat Requests")),
      body:   FutureBuilder(
          future: initialize(),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.connectionState == ConnectionState.done) {
              return ValueListenableBuilder(valueListenable: requestedUsersNotifier, builder: (context, List<String> currList, child){
                return ListView.builder(
                    itemCount: requestedUsers.length,
                    itemBuilder: (context, index) {
                      return Dismissible(key: Key("$requestedUsers[index]"), child: chatRequestBuilder(index, context),
                          onDismissed: (direction) {
                            if (direction == DismissDirection.startToEnd){
                              setState((){
                                removal(index);
                              });
                            }
                            else {
                              setState((){
                                removal(index);
                              });
                            }
                          });
                    });

              }
              );
            }
            else {
              return Text("Error");
            }
          })
      )
    );
  }
}


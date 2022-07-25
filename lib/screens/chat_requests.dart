import 'package:close_contact/firestore/info-setter.dart';
import 'package:close_contact/screens/chats_home.dart';
import 'package:close_contact/screens/profile_info.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';
import 'package:close_contact/firestore/info-getter.dart';

class ChatRequestPage extends StatefulWidget {
  final User user;
  ChatRequestPage(this.user, {Key? key}) : super(key: key);

  @override
  State<ChatRequestPage> createState() => ChatRequest(user);
}

class ChatRequest extends State<ChatRequestPage> {
  final User user;
  ChatRequest(this.user);
  String imageUrl = " ";
  List<String> requestedUIDs = [];
  List<String> requestedNames = [];
  String currName = "";
  List<String> requestedImages = [];
  String currImage = "";
  FirebaseFirestore db = FirebaseFirestore.instance;

  initialize() async {
    requestedUIDs = await InfoGetter.currIncoming(userid: user.uid);
    await currNameSetter(requestedUIDs);
    await currImageSetter(requestedUIDs);
    if (!mounted) return;
  }

  Future<String> maptoNames(id) async {
    String name = await InfoGetter.nameGetter(userID: id);
    return name;
  }

  Future<void> currNameSetter(List<String> str) async {
    for (String item in str) {
      var temp = await maptoNames(item);
      currName = temp;
      requestedNames.add(currName);
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

  void removal(index) {
    requestedUIDs.removeAt(index);
    requestedNames.removeAt(index);
    requestedImages.removeAt(index);
  }

  Widget chatRequestBuilder(index, context) {
    String result = requestedNames[index];
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      ProfileInfo(user, requestedUIDs[index])),
            ),
        child: Row(
          children: [
            Column(children: [
              UserProfileAvatar(
                avatarUrl: requestedImages[index],
                onAvatarTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProfileInfo(user, requestedUIDs[index])),
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
            Text(result)
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<List<String>> requestedUsersNotifier =
        ValueNotifier(requestedUIDs);
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            leading: BackButton(
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChatsHome(user)),
                    )),
            title: const Text("Chat Requests")),
        body: FutureBuilder(
            future: initialize(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return ValueListenableBuilder(
                    valueListenable: requestedUsersNotifier,
                    builder: (context, List<String> currList, child) {
                      return ListView.builder(
                          itemCount: requestedUIDs.length,
                          itemBuilder: (context, index) {
                            return chatRequestBuilder(index, context);
                          });
                    });
              } else {
                return Text("Error");
              }
            })));
  }
}

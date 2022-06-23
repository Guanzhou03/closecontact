import 'package:close_contact/firestore/info-getter.dart';
import 'package:close_contact/models/message_model.dart';
import 'package:close_contact/screens/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_firebase_chat_core/flutter_firebase_chat_core.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:close_contact/screens/home.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

class RecentChats extends StatelessWidget {
  final User user;
  List<String> currConversations = []; //list of userIDS that user is talking to
  RecentChats(this.user, this.currConversations, {Key? key}) : super(key: key);
  List<String> requestedNames = [];
  List<String> requestedImages = [];
  List<String> roomIDs = [];

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

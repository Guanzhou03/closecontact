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
  List<String> currConversations = ['jDYEwSEStySyb4DRfBmjGsUnpF63','JqD1JCk5MZR5gBMxzYHCd66z6po2', 'QLVpECCTMAgPAZr1dw0TuxQsljF3']; //list of userIDS that user is talking to
  RecentChats(this.user, this.currConversations, {Key? key}) : super(key: key);
  List<String> requestedNames = [];
  List<String> requestedImages = [];
  List<String> roomIDs = [];

  initialize() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    requestedNames =  await currConversations.map((id) => maptoNames(id).toString()).toList();
    requestedImages = await currConversations.map((id) => maptoImage(id).toString()).toList();
    roomIDs = currConversations.map((id) => maptoRoomID(id).toString()).toList();
  }

  Future<String> maptoNames(id) async {
    String name = await InfoGetter.nameGetter(userID: id);
    return name;
  }
  Future<String> maptoImage(id) async {
  String url = await InfoGetter.imageURLGetter(userID:id);
  return url;
  }

  String maptoRoomID(id)  {
    return user.uid.compareTo(id) > 0 ? user.uid + id : id + user.uid;
  }
  String getUserName(types.User user) =>
      '${user.firstName ?? ''} ${user.lastName ?? ''}'.trim();

  Widget _buildAvatar(index) {
    return UserProfileAvatar(
      avatarUrl: requestedImages[index],
      onAvatarTap: () {
        print("tapped");
      },
      radius: 40,
      isActivityIndicatorSmall: false,
      avatarBorderData: AvatarBorderData(
        borderColor: Colors.white,
        borderWidth: 5.0,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return  FutureBuilder(
        future: initialize(),
    builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
      child: CircularProgressIndicator(),
      );
    }
    if (snapshot.connectionState == ConnectionState.done) {
      Size size = MediaQuery.of(context).size;
      return SizedBox(height: size.height,width: size.height,child:
     Scaffold(
      body: ListView.builder(
     itemCount: currConversations.length,
       itemBuilder: (context, index) {
         //final room = snapshot.data![index];

         return GestureDetector(
           onTap: () {
             Navigator.of(context).push(
               MaterialPageRoute(
                 builder: (context) => Chat(
                   chatRoomId: roomIDs[index],
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
     )
    ));
    }
    else {
      return Text("error");
    }
  }
  )
    );
  }
}
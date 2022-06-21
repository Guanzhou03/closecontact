import 'package:close_contact/firestore/info-getter.dart';
import 'package:close_contact/models/message_model.dart';
import 'package:close_contact/screens/chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class RecentChats extends StatelessWidget {
  final User user;
  List<String> currConversations = []; //list of userIDS that user is talking to
  RecentChats(this.user, this.currConversations, {Key? key}) : super(key: key);
  List<String> requestedNames = [];
  List<String> requestedImages = [];

  initialize() async {
    FirebaseFirestore db = FirebaseFirestore.instance;
    requestedNames =  await currConversations.map((id) => maptoNames(id).toString()).toList();
    requestedImages = await currConversations.map((id) => maptoImage(id).toString()).toList();
  }
  maptoNames(id) async {
    String name = await InfoGetter.nameGetter(userID: id);
    return name;
  }
  maptoImage(id) async {
    String url = await InfoGetter.imageURLGetter(userID:id);
    return url;
    }

  @override
  Widget build(BuildContext context) {
    currConversations.add('jDYEwSEStySyb4DRfBmjGsUnpF63');
    currConversations.add('JqD1JCk5MZR5gBMxzYHCd66z6po2');
    currConversations.add('QLVpECCTMAgPAZr1dw0TuxQsljF3');
    return  FutureBuilder(
        future: initialize(),
    builder: ((context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
      child: CircularProgressIndicator(),
      );
    }
    if (snapshot.connectionState == ConnectionState.done) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              final Message chat = chats[index];
              return GestureDetector(
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ChattingPage(
                      user.uid, currConversations[index]
                    ),
                  ),
                ),
                child: Container(
                  margin: EdgeInsets.only(top: 5.0, bottom: 5.0, right: 20.0),
                  padding:
                  EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                  decoration: BoxDecoration(
                      color: chat.unread ? Color(0xFFFFEFEE) : Colors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      )),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            radius: 35.0,
                            backgroundImage: AssetImage(requestedImages[index]),
                          ),
                          SizedBox(width: 10.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                requestedNames[index],
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.45,
                                child: Text(
                                  chat.text,
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: <Widget>[
                          Text(
                            chat.time,
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 5.0),
                          chat.unread
                              ? Container(
                            width: 40.0,
                            height: 20.0,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              'NEW',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                              : Text(''),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
    }
    else {
      return Text("error");
    }
  }
  )
    );
  }
}
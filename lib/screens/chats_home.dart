import 'package:close_contact/firestore/info-getter.dart';
import 'package:close_contact/screens/chat_requests.dart';
import 'package:close_contact/widgets/category_selector.dart';
import 'package:close_contact/widgets/recent_chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/message_model.dart';

class ChatsHome extends StatelessWidget {
  final User user;
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<String> currConversations =
      []; //list of userIDs that the user is chatting with

  void initialMessages() async {
    currConversations = await InfoGetter.currConvoGetter(userid: user.uid);
  }

  ChatsHome(this.user, {Key? key}) : super(key: key);
  var _counter = 0; //increment this when there is chat request

  @override
  Widget build(BuildContext context) {
    initialMessages();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[50],
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Chats",
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.grey),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => ChatRequestPage(this.user)),
                  );
                },
                icon: new Stack(
                  children: <Widget>[
                    new Icon(Icons.notifications),
                    new Positioned(
                      right: 0,
                      child: new Container(
                        padding: EdgeInsets.all(1),
                        decoration: new BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(6),
                        ),
                        constraints: BoxConstraints(
                          minWidth: 12,
                          minHeight: 12,
                        ),
                        child: new Text(
                          '$_counter', //this is the number of chat requests
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 8,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  ],
                ),
                label: Text('Chat Requests'), // <-- Text
              )
            ],
          ),
        ),
        elevation: 0.0,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Container(
                //feel free to edit decorations
                child: RecentChats(this.user,
                    currConversations), //user we need to retrieve from database
              ),
            ),
          )
        ],
      ),
    );
  }
}

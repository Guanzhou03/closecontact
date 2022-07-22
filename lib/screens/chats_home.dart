import 'package:close_contact/firestore/info-getter.dart';
import 'package:close_contact/screens/chat_requests.dart';
import 'package:close_contact/widgets/recent_chats.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatsHome extends StatelessWidget {
  final User user;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  List<String> currConversations =
      []; //list of userIDs that the user is chatting with

  void initialMessages() async {
    currConversations = await InfoGetter.currConvoGetter(userid: user.uid);
  }

  ChatsHome(this.user, {Key? key}) : super(key: key);
  //var _counter = 0; //increment this when there is chat request

  @override
  Widget build(BuildContext context) {
    initialMessages();
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.amber[50],
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text(
                "Close Contacts",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
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
                    // new Positioned(
                    //   right: 0,
                    //   child: new Container(
                    //     padding: EdgeInsets.all(1),
                    //     decoration: new BoxDecoration(
                    //       color: Colors.red,
                    //       borderRadius: BorderRadius.circular(6),
                    //     ),
                    //     constraints: BoxConstraints(
                    //       minWidth: 12,
                    //       minHeight: 12,
                    //     ),
                    //     child: new Text(
                    //       '$_counter', //this is the number of chat requests
                    //       style: new TextStyle(
                    //         color: Colors.white,
                    //         fontSize: 8,
                    //       ),
                    //       textAlign: TextAlign.center,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                label: Text('Chat Requests'), // <-- Text
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Container(
                //feel free to edit decorations
                child: RecentChatsPage(this.user,
                    currConversations), //user we need to retrieve from database
              ),
            ),
          )
        ],
      ),
    );
  }
}

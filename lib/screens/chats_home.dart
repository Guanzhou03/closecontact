import 'package:close_contact/screens/chat_requests.dart';
import 'package:close_contact/widgets/category_selector.dart';
import 'package:close_contact/widgets/recent_chats.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatsHome extends StatelessWidget {
  final User user;
  ChatsHome(this.user, {Key? key}) : super(key: key);
  var _counter = 0; //increment this when there is chat request

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[50],
        title: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Text("Chats",style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold),),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(primary: Colors.grey),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (context) => ChatRequestPage(this.user)),
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
                color: Theme.of(context).accentColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: <Widget>[
                  RecentChats(this.user), //user we need to retrieve from database
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
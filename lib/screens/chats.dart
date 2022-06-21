import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:close_contact/models/message_model.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';

import '../firestore/info-getter.dart';
//import 'package:close_contact/models/user_model.dart';

class ChattingPage extends StatefulWidget {
  String receiverUID;
  String senderUID;
  ChattingPage(this.receiverUID, this.senderUID, {Key? key}) : super(key: key);

  @override
  _ChatsState createState() => _ChatsState(this.senderUID, this.receiverUID);
}

class _ChatsState extends State<ChattingPage> {
  String receiverUID;
  String senderUID;
  _ChatsState(this.receiverUID, this.senderUID);

  List<Message> messages = [];
  var num = 3;
  void initialMessages() {
    for (int i = 0; i < 5; i++) {
      messages.add(Message(
        senderID: senderUID,
        time: DateTime.now().toString(),
        text: "Test message",
        unread: true
      ));
    }
  }
  maptoNames(id) async {
    String name = await InfoGetter.nameGetter(userID: id);
    return name;
  }
  maptoImage(id) async {
    String url = await InfoGetter.imageURLGetter(userID:id);
    return url;
  }
  
  _buildMessage(Message message, bool isMe) {
    final container = Container(
      margin: isMe
          ? EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
        left: 80.0,
      )
          : EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      padding: EdgeInsets.symmetric(horizontal: 25.0, vertical: 15.0),
      width: MediaQuery.of(context).size.width * 0.75,
      decoration: BoxDecoration(
        color: isMe ? Theme.of(context).accentColor : Color(0xFFFFEFEE),
        borderRadius: isMe
            ? BorderRadius.only(
          topLeft: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
        )
            : BorderRadius.only(
          topRight: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            message.time,
            style: TextStyle(
              color: Colors.black,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            message.text,
            style: TextStyle(
              color: Colors.black54,
              fontSize: 16.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );

    if (isMe) {
      return container;
    }

    return Row(
      children: <Widget>[
        container,
      ],
    );
  }

  _buildMessageComposer() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.0),
      height: 70.0,
      color: Colors.white,
      child: Row(
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.attach_file),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
          Expanded(
            child: TextField(
              textCapitalization: TextCapitalization.sentences,
              onChanged: (value) {},
              decoration: InputDecoration.collapsed(
                hintText: 'Send a message...',
              ),
            ),
          ),
          IconButton(
            icon: Icon(Icons.send),
            iconSize: 25.0,
            color: Theme.of(context).primaryColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        leading: UserProfileAvatar(
          avatarUrl: maptoImage(senderUID),
          onAvatarTap: () {
            print("tapped");
          },
          avatarSplashColor: Colors.purple,
          radius: 50,
          isActivityIndicatorSmall: false,
          avatarBorderData: AvatarBorderData(
            borderColor: Colors.white,
            borderWidth: 5.0,
          ),
        ),
        title: Text(
          maptoNames(senderUID), //should be the sender user
          style: TextStyle(
            fontSize: 24.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.more_horiz),
            iconSize: 30.0,
            color: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Column(
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
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: ListView.builder(
                    reverse: true,
                    padding: EdgeInsets.only(top: 15.0),
                    itemCount: messages.length,
                    itemBuilder: (BuildContext context, int index) {
                      final Message message = messages[index];
                      final bool isMe = message.senderID == currentUser.id;
                      return _buildMessage(message, isMe);
                    },
                  ),
                ),
              ),
            ),
            _buildMessageComposer(),
          ],
        ),
      ),
    );
  }
}
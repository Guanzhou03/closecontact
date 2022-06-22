import 'dart:io';
import 'package:close_contact/firestore/info-getter.dart';
import 'package:close_contact/models/constants.dart';
import 'package:close_contact/models/database.dart';
import 'package:close_contact/models/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Chat extends StatefulWidget {
  final String chatRoomId;
  final String me;
  final String other;

  Chat({required this.chatRoomId, required this.me, required this.other});

  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  Stream<QuerySnapshot> chats = Stream.empty();
  TextEditingController messageEditingController = new TextEditingController();
  String myName = "";
  String otherName = "";
  Future<void> _future = Future(
    () {},
  );

  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var temp = snapshot.data!.docs[index].data()! as Map;
                  return MessageTile(
                    message: temp["message"],
                    sendByMe: temp["sendBy"] == myName,
                  );
                })
            : Container();
      },
    );
  }

  addMessage() {
    if (messageEditingController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "sendBy": myName,
        "message": messageEditingController.text,
        'time': DateTime.now().millisecondsSinceEpoch,
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  Future<void> initialise() async {
    myName = await InfoGetter.nameGetter(userID: widget.me);
    otherName = await InfoGetter.nameGetter(userID: widget.other);
  }

  @override
  void initState() {
    _future = initialise();
    DatabaseMethods().getChats(widget.chatRoomId).then((val) {
      setState(() {
        chats = val;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: ((context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            return Scaffold(
              appBar: AppBar(title: Text(otherName)),
              body: Container(
                child: Stack(
                  children: [
                    chatMessages(),
                    Container(
                      alignment: Alignment.bottomCenter,
                      width: MediaQuery.of(context).size.width,
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                        color: Color(0x54FFFFFF),
                        child: Row(
                          children: [
                            Expanded(
                                child: TextField(
                              controller: messageEditingController,
                              style: simpleTextStyle(),
                              decoration: InputDecoration(
                                  hintText: "Message ...",
                                  hintStyle: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 16,
                                  ),
                                  border: InputBorder.none),
                            )),
                            SizedBox(
                              width: 16,
                            ),
                            GestureDetector(
                              onTap: () {
                                addMessage();
                              },
                              child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                          colors: [
                                            const Color(0x36FFFFFF),
                                            const Color(0x0FFFFFFF)
                                          ],
                                          begin: FractionalOffset.topLeft,
                                          end: FractionalOffset.bottomRight),
                                      borderRadius: BorderRadius.circular(40)),
                                  padding: EdgeInsets.all(12),
                                  child: Image.asset(
                                    "assets/images/test6.jpg",
                                    height: 25,
                                    width: 25,
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Text("ERROR");
        }));
  }
}

class MessageTile extends StatelessWidget {
  final String message;
  final bool sendByMe;

  MessageTile({required this.message, required this.sendByMe});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 8, bottom: 8, left: sendByMe ? 0 : 24, right: sendByMe ? 24 : 0),
      alignment: sendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin:
            sendByMe ? EdgeInsets.only(left: 30) : EdgeInsets.only(right: 30),
        padding: EdgeInsets.only(top: 17, bottom: 17, left: 20, right: 20),
        decoration: BoxDecoration(
            borderRadius: sendByMe
                ? BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomLeft: Radius.circular(23))
                : BorderRadius.only(
                    topLeft: Radius.circular(23),
                    topRight: Radius.circular(23),
                    bottomRight: Radius.circular(23)),
            gradient: LinearGradient(
                colors: sendByMe
                    ? [const Color(0xff007EF4), const Color(0xff2A75BC)]
                    : [
                        Color.fromARGB(255, 206, 211, 215),
                        Color.fromARGB(255, 103, 108, 108)
                      ]
                //[const Color(0x1AFFFFFF), const Color(0x1AFFFFFF)],
                )),
        child: Text(message,
            textAlign: TextAlign.start,
            style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontFamily: 'OverpassRegular',
                fontWeight: FontWeight.w300)),
      ),
    );
  }
}

import 'dart:ffi';
import 'dart:io';

import 'package:close_contact/firestore/info-getter.dart';
import 'package:close_contact/models/database.dart';
import 'package:close_contact/models/text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ntp/ntp.dart';

import '../firestore/info-setter.dart';

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
  String currImage = "";
  String adminID = "PJMrJVoRZWVNR4rnI8ULYKaPJjg1";
  bool isBlocked = false;

  Widget chatMessages() {
    return StreamBuilder<QuerySnapshot>(
      stream: chats,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                physics: const AlwaysScrollableScrollPhysics(),
                reverse: true,
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var temp = snapshot
                      .data!.docs[snapshot.data!.docs.length - 1 - index]
                      .data()! as Map;
                  return MessageTile(
                    messageType: temp["messageType"],
                    message: temp["message"],
                    sendByMe: temp["sendBy"] == myName,
                  );
                })
            : Container();
      },
    );
  }

  Widget messageBar() {
    return Container(
      alignment: Alignment.bottomCenter,
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        color: Color(0x54FFFFFF),
        child: Row(
          children: [
            GestureDetector(
              onTap: () async {
                await getUploadImage();
                addImage();
              },
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            ),
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
            GestureDetector(
              onTap: () {
                if (!isBlocked)
                addMessage();
                else {
                  print(isBlocked);
                  showDialog(context: context, builder: (context) => AlertDialog(content: Text("Unable to send message: Blocked")));
                }
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
                  child: Icon(Icons.send)),
            ),
          ],
        ),
      ),
    );
  }

  Future getUploadImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    String uid = widget.me;
    int time = DateTime.now().microsecondsSinceEpoch;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("chatpics")
        .child("$uid" + "$time" + ".jpg");
    await ref.putFile(imageTemp);
    await ref.getDownloadURL().then((value) {
      setState(() {
        currImage = value;
      });
    });
  }

  addImage() async {
    if (currImage.isNotEmpty) {
      DateTime startDate = new DateTime.now().toLocal();
      int offset = await NTP.getNtpOffset(localTime: startDate);
      Map<String, dynamic> chatMessageMap = {
        "messageType": "Image",
        "sendBy": myName,
        "message": currImage,
        'time': startDate.add(new Duration(milliseconds: offset)), //real time
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);
      setState(() {
        currImage = "";
      });
    }
  }

  addMessage() async {
    if (messageEditingController.text.isNotEmpty) {
      DateTime startDate = new DateTime.now().toLocal();
      int offset = await NTP.getNtpOffset(localTime: startDate);
      Map<String, dynamic> chatMessageMap = {
        "messageType": "Text",
        "sendBy": myName,
        "message": messageEditingController.text,
        'time': startDate.add(new Duration(milliseconds: offset)), //real time
      };

      DatabaseMethods().addMessage(widget.chatRoomId, chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });
    }
  }

  addAdminMessage() async {
    messageEditingController.text = "You have reported user with userID " + widget.other + ".\n Kindly explain the issue";
    DateTime startDate = new DateTime.now().toLocal();
    int offset = await NTP.getNtpOffset(localTime: startDate);
    Map<String, dynamic> chatMessageMap = {
      "messageType": "Text",
      "sendBy": adminID,
      "message": messageEditingController.text,
      'time': startDate.add(new Duration(milliseconds: offset)), //real time
    };
      DatabaseMethods().addMessage(maptoRoomID(adminID), chatMessageMap);

      setState(() {
        messageEditingController.text = "";
      });

  }

  Future<void> initialise() async {
    myName = await InfoGetter.nameGetter(userID: widget.me);
    otherName = await InfoGetter.nameGetter(userID: widget.other);
    isBlocked = await InfoSetter.setRoomState(roomID: widget.chatRoomId);
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

  String maptoRoomID(id) {
    return widget.me.compareTo(id) > 0 ? widget.me + id : id + widget.me;
  }

  void handleClick(String value) async {
      if (value == 'Report user') {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => Chat(
              chatRoomId: maptoRoomID(adminID),
              me: widget.me,
              other: adminID,
            ),
          ));
        await InfoSetter.setCurrConvo(
            userid: widget.me,
            newConvo: adminID);
        await InfoSetter.setCurrConvo(
            userid: adminID,
            newConvo: widget.me);
        await addAdminMessage();
      }
      else if (value == "Block/Unblock user"){
        var initiator = await InfoGetter.blockerGetter(roomID: widget.chatRoomId);
        if (widget.me == initiator || initiator == "") {
          await InfoSetter.toggleBlockedState(roomID: widget.chatRoomId, initiator: widget.me);
          isBlocked = isBlocked == true ? false : true;
          showDialog(context: context, builder: (context) => AlertDialog(content: Text("Blocked/Unblocked successfully")));
        }
        else {
          showDialog(context: context, builder: (context) => AlertDialog(content: Text("You are already blocked")));
        }
      }
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
              resizeToAvoidBottomInset: false,
              appBar: AppBar(title: Text(otherName), actions: <Widget>[
                PopupMenuButton<String>(
                  onSelected: handleClick,
                  itemBuilder: (BuildContext context) {
                    return {'Report user', "Block/Unblock user"}.map((String choice) {
                      return PopupMenuItem<String>(
                        value: choice,
                        child: Text(choice),
                      );
                    }).toList();
                  },
                ),
              ]),
              body: Container(
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 100,
                      top: 0,
                      left: 0,
                      right: 0,
                      child: SizedBox(
                        width: 400,
                        child: chatMessages(),
                      ),
                    ),
                    messageBar(),
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
  final String messageType;

  MessageTile(
      {required this.messageType,
      required this.message,
      required this.sendByMe});

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
                      ])),
        child: messageType == "Image"
            ? Image.network(message)
            : Text(message,
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

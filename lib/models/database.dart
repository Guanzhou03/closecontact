import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  createChatRoom(String roomID, chatRoomMap) {
    FirebaseFirestore.instance.collection("rooms")
        .doc(roomID).set(chatRoomMap).catchError((e) => print(e.toString()));
  }

  getChats(String chatRoomId) async{
    return FirebaseFirestore.instance
        .collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }


  Future<void> addMessage(String chatRoomId, chatMessageData){
    return FirebaseFirestore.instance.collection("chatRoom")
        .doc(chatRoomId)
        .collection("chats")
        .add(chatMessageData).catchError((e){
      print(e.toString());
    });
  }

  Future<Stream<QuerySnapshot>> getUserChats(String itIsMyName) async {
    return await FirebaseFirestore.instance
        .collection("rooms")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }
}
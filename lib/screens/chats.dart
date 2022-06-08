import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Chats extends StatelessWidget {
  final User user;
  Chats(this.user, {Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Chats page")),
      body: Text("Chats page work in progress")
    );
  }
}
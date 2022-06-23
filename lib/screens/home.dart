import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:close_contact/widgets/card_stack.dart';
import 'package:close_contact/widgets/background.dart';
import 'package:flutter/cupertino.dart';

class Home extends StatelessWidget {
  final User user;
  Home(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Home Page")),
      body: Stack(children: [
        BackgroudCurveWidget(),
        CardsStackWidget(),
      ]),
    );
  }
}

enum Swipe { left, right, none }

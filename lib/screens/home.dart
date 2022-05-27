import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:close_contact/screens/signin.dart';
import 'package:close_contact/widgets/profile_card.dart';
import 'package:close_contact/widgets/card_stack.dart';
import 'package:close_contact/widgets/background.dart';

class Home extends StatefulWidget {
  User user;
  Home(this.user, {Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: const Text("Home Page")),
      body: Stack(
          children: const [
            BackgroudCurveWidget(),
            CardsStackWidget(),
          ]),
        );
  }
}
enum Swipe { left, right, none }

import 'package:close_contact/screens/report_bug.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:close_contact/widgets/card_stack.dart';
import 'package:close_contact/widgets/background.dart';

class Home extends StatelessWidget {
  final User user;
  Home(this.user, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Find Close Contacts"), actions: [
        ElevatedButton.icon(icon: Icon(Icons.report), label: Text("Report a bug"),
    style: ElevatedButton.styleFrom(primary: Colors.redAccent),
    onPressed: () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) => ReportBugPage(this.user)),
      );
    })],),
      body: Stack(fit: StackFit.loose, children: [
        BackgroudCurveWidget(),
        CardsStackWidget(),
      ]),
    );
  }
}

enum Swipe { left, right, none }

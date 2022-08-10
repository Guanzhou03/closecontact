import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'home.dart';

class ReportBugPage extends StatefulWidget{
  final User user;
  ReportBugPage(this.user, {Key? key}) : super(key: key);

  @override
  State<ReportBugPage> createState() => ReportBug(user);
}

class ReportBug extends State<ReportBugPage> {
  final User user;
  ReportBug(this.user);
  TextEditingController _issueController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  CollectionReference feedbackCollection = FirebaseFirestore.instance.collection('feedback');

  @override
  Widget build(BuildContext context) {
    return Scaffold(floatingActionButton: IconButton(icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pushReplacement(
          MaterialPageRoute(
              builder: (context) => Home(user)),
        )),
        floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
        body: Column(children: [
      Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.fromLTRB(10, 50, 10, 60),
          child: const Text(
            'Feedback',
            style: TextStyle(
                color: Colors.brown,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w900,
                fontSize: 30),
          )),
      Container(
      alignment: Alignment.centerLeft,
      padding: const EdgeInsets.fromLTRB(25, 10, 0, 5),
      child: Column(
        children: <Widget>[
          const Text('Type of issue ',
              style: TextStyle(fontSize: 14)),
        ],
      ),
    ),
      Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: TextFormField(
          controller: _issueController,
          decoration: InputDecoration(
              suffixIcon: DropdownButtonFormField(
                hint: Container(child: Text("Select type of issue",
                    style: TextStyle(color: Colors.black)),
                    padding: EdgeInsets.only(left:8)),
                items: <String>[
                  'Bug',
                  'Feedback',
                  'Other'
                ].map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child:
                    Container(child: Text(value), padding: EdgeInsets.only(left:8)),
                  );
                }).toList(),
                onChanged: (value) {
                  _issueController.text = value as String;
                },
              ),
              contentPadding:
              const EdgeInsets.fromLTRB(10, 0, 0, 0),
              border: OutlineInputBorder()),
        ),
      ),
      Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.fromLTRB(25, 0, 0, 5),
          child: const Text(
            'Description',
            style: TextStyle(fontSize: 14),
          )),
      Container(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        child: TextFormField(
          controller: _descriptionController,
          maxLength: 500,
          maxLines: null,
          decoration: const InputDecoration(
            contentPadding:
            const EdgeInsets.fromLTRB(10, 0, 0, 0),
            border: OutlineInputBorder(),
            // labelText: "Add a bio",
            // labelStyle: TextStyle(fontSize: 13),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.fromLTRB(130, 20, 130, 0),
        height: 40,
        padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
        child: ElevatedButton(
          child: const Text('Submit form'),
          style: ElevatedButton.styleFrom(primary: Colors.blue),
          onPressed: () {
            feedbackCollection.add({
              'type': _issueController.text,
              'description': _descriptionController.text
            });
            showDialog(
                context: context,
                builder: (context) => AlertDialog(
                    content: Text(
                       "Thank you for your feedback!")));
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (context) => Home(this.user)),
            );
          },
        ),
      )
    ]));
  }
}


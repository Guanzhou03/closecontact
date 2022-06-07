import 'package:close_contact/widgets/sports_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:close_contact/screens/signin.dart';
import 'package:close_contact/widgets/profile_card.dart';
import 'package:close_contact/widgets/card_stack.dart';
import 'package:close_contact/widgets/background.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:close_contact/widgets/sports_button.dart';

void main() => runApp(MaterialApp(home: Profile()));

class Profile extends StatelessWidget {
  Profile({Key? key}) : super(key: key);

  static const String _title = 'Profile Screen';
  final List<String> testList = ['1', '2', '3', '4', '5'];
  var sportsTapped = false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
      backgroundColor: Colors.amber[50],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Form(
          child: ListView(
            children: <Widget>[
              Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  child: const Text(
                    'My Profile',
                    style: TextStyle(
                        color: Colors.brown,
                        fontFamily: 'Murray Hill',
                        fontStyle: FontStyle.italic,
                        fontWeight: FontWeight.w900,
                        fontSize: 40),
                  )),
              Stack(
                alignment: Alignment.center,
                  children: [
                UserProfileAvatar(
                avatarUrl: 'https://picsum.photos/id/237/5000/5000',
                onAvatarTap: () {
                 print("tapped");
                },
                avatarSplashColor: Colors.purple,
                radius: 100,
                isActivityIndicatorSmall: false,
                avatarBorderData: AvatarBorderData(
                  borderColor: Colors.white,
                  borderWidth: 5.0,
                ),
              ),
                Positioned(top: 120, right: 60,
                child:
                    Transform.scale(
                      scale: 0.7,
                child: Column(
                    children: [
                      Container(
                        width: 85,
                        height: 85,
                        child: Stack(
                          children: [
                            Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [Colors.pink, Colors.red],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      spreadRadius: 10,
                                      blurRadius: 15,
                                      // changes position of shadow
                                    ),
                                  ]),
                              child: Icon(
                                Icons.camera_alt,
                                size: 45,
                                color: Colors.white,
                              ),
                            ),
                            Positioned(
                              bottom: 8,
                              right: 0,
                              child: Container(
                                width: 25,
                                height: 25,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.1),
                                        spreadRadius: 10,
                                        blurRadius: 15,
                                        // changes position of shadow
                                      ),
                                    ]),
                                child: Center(
                                  child: Icon(Icons.add, color: Colors.grey),
                                ),
                              ),
                            )
                          ],
                        ),
                      )],
                  ),
                ))]),



              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                  child: const Text(
                    'About me',
                    style: TextStyle(fontSize: 14),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    border: OutlineInputBorder(),
                    labelText: "Add a bio",
                      labelStyle: TextStyle(fontSize: 13)
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                  child: Column(children: <Widget>[const Text(
                    'My Interests ',
                    style: TextStyle(fontSize: 14)),
              ])
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                    suffixIcon: DropdownButtonFormField(
                      items: <String>['Sports', 'Activities', 'Hobbies', 'Talents'].map((String value) {
                        return DropdownMenuItem<String>(
                          onTap: (){
                            sportsTapped = true;
                            showDialog<String>(
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                              title: const Text('Sports'),
                              content: SportsApp(),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () => Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () => { value = getActivities(),
                                    Navigator.pop(context, 'OK')},
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                          },
                          value: value,
                          child: Text(value, textAlign: TextAlign.center)
                        );
                      }).toList(),
                      onChanged: (_) {},
                    ),
                      contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      border: OutlineInputBorder(),
                      labelText: "Add your interests",
                      labelStyle: TextStyle(fontSize: 13)
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                  child: const Text(
                    'Faculty/Course of study ',
                    style: TextStyle(fontSize: 14),
                  )),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextFormField(

                  decoration: InputDecoration(
                      suffixIcon: DropdownButtonFormField(
                        items: <String>['Computing', 'Fac2', 'Fac3', 'Fac4'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, textAlign: TextAlign.right),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      border: OutlineInputBorder(),
                      labelText: "Fac",
                      labelStyle: TextStyle(fontSize: 13)
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                  child: Column(children: <Widget>[const Text(
                      'Year of Study ',
                      style: TextStyle(fontSize: 14)),
                  ])
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      suffixIcon: DropdownButtonFormField(
                        items: <String>['Year 1', 'Year 2', 'Year 3', 'Year 4', 'Year 5'].map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, textAlign: TextAlign.center),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      border: OutlineInputBorder(),
                      labelText: "Year of study",
                      labelStyle: TextStyle(fontSize: 13)
                  ),
                ),
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Log Out'),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () async {
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
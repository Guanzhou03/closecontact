import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:close_contact/widgets/card_stack.dart';
import 'package:close_contact/widgets/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';
import 'package:close_contact/firestore/info-getter.dart';

class ChatRequest extends StatelessWidget {
  final User user;
  ChatRequest(this.user, {Key? key}) : super(key: key);
  String _faculty = "";
  String _year = "";
  String _activityString = "";
  static List _activities = ["Running"];
  Future<void> _future = Future(() {});
  TextEditingController _bioController = TextEditingController();
  TextEditingController _facultyController = TextEditingController();
  TextEditingController _yearController =
  TextEditingController(text: "Please choose your year of study");
  String imageUrl = " ";

  Future<void> setControllers() async {
    var bio = await InfoGetter.bioGetter(user: user);
    _bioController.text = bio;
    var faculty = await InfoGetter.facultyGetter(user: user);
    _facultyController.text = faculty;
    _faculty = faculty;
    var year = await InfoGetter.yearGetter(user: user);
    _yearController.text = year;
    _year = year;
    imageUrl = await user.photoURL == null ? " " : user.photoURL as String;
    var activities = await InfoGetter.activitiesGetter(user: user);
    _activities =
        activities.substring(1, activities.length - 1).split(",").map((x) {
          if (x[0] == " ") {
            return x.substring(1);
          }
          return x;
        }).toList();
  }

  @override
  Widget build(BuildContext context) {
    setControllers();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Chat Requests")),
      body: Column(
          children: [
            Row(children: [
              Column(children:[
              UserProfileAvatar(
                avatarUrl: imageUrl == " "
                    ? 'https://picsum.photos/id/237/5000/5000'
                    : imageUrl,
                onAvatarTap: () {
                  return AlertDialog(content: Text("HI I AM TOMMY I LOVE TO PLAY MAHJONG AND BADMINTON! JIO ME IF YOU ARE UP FOR EITHER!"));
                },
                avatarSplashColor: Colors.purple,
                radius: 50,
                isActivityIndicatorSmall: false,
                avatarBorderData: AvatarBorderData(
                  borderColor: Colors.white,
                  borderWidth: 5.0,
                ),
              ),
              Text("Year 1 " + "Computing")]),
              Flexible(child: Column(
                  children: [Text("Tommy Goh"),
                  ListView.builder(
                      // scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: _activities.length,
                      itemBuilder: (context, index) {
                        return Text(_activities[index]);
                      }
                      )
                      ])),
              IconButton(onPressed: (){}, icon: Icon(Icons.add_circle)),
              IconButton(onPressed: (){}, icon: Icon(Icons.cancel_outlined))
            ],
            ),
          ]),
    );
  }
}
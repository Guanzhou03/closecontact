import 'package:close_contact/screens/chats_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:close_contact/widgets/card_stack.dart';
import 'package:close_contact/widgets/background.dart';
import 'package:flutter/cupertino.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';
import 'package:close_contact/firestore/info-getter.dart';

class ProfileInfo extends StatelessWidget{
  final String UID;
  ProfileInfo(this.UID, {Key? key}) : super(key: key);

  String _faculty = "";
  String _year = "";
  String _activityString = "";
  static List _activities = ["Running, Climbing"];
  Future<void> _future = Future(() {});
  TextEditingController _bioController = TextEditingController();
  TextEditingController _facultyController = TextEditingController();
  TextEditingController _yearController =
  TextEditingController(text: "Please choose your year of study");
  var imageUrl = " ";

  Future<void> setControllers() async {
    var bio = await InfoGetter.bioGetter(userID: UID);
    _bioController.text = bio;
    var faculty = await InfoGetter.facultyGetter(userID: UID);
    _facultyController.text = faculty;
    _faculty = faculty;
    var year = await InfoGetter.yearGetter(userID: UID);
    _yearController.text = year;
    _year = year;
    imageUrl = await InfoGetter.imageURLGetter(userID: UID);
    var activities = await InfoGetter.activitiesGetter(userID: UID);
    _activities =
        activities.substring(1, activities.length - 1).split(",").map((x) {
          if (x[0] == " ") {
            return x.substring(1);
          }
          return x;
        }).toList();
  }

  Widget _buildChip(String label) {
    return Chip(
      labelPadding: EdgeInsets.all(0),
      // avatar: CircleAvatar(
      //   backgroundColor: Colors.white70,
      //   child: Text(label[0].toUpperCase()),
      // ),
      label: Text(
        label,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.redAccent,
      elevation: 3.0,
      shadowColor: Colors.grey[60],
      padding: EdgeInsets.all(5.0),
    );
  }

  List<String> testInterest = ["Running", "Chess", "Climbing", "Mahjong", "Foodie"];

  Widget chipList() {
    return Wrap(
        spacing: 3.0,
        children: testInterest.map((interest) => _buildChip(interest)).toList()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: Text("User Info")),
        body: FutureBuilder(
    future: setControllers(),
    builder: ((context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
    return const Center(
    child: CircularProgressIndicator(),
    );
    }
    if (snapshot.connectionState == ConnectionState.done) {
      return Column(
          children: [UserProfileAvatar(
            avatarUrl: imageUrl == " "
                ? 'https://picsum.photos/id/237/5000/5000'
                : imageUrl,
            onAvatarTap: () {
              print("tapped");
            },
            avatarSplashColor: Colors.purple,
            radius: 80,
            isActivityIndicatorSmall: false,
            avatarBorderData: AvatarBorderData(
              borderColor: Colors.white,
              borderWidth: 5.0,
            ),
          ),
            Text("Name: " + "Test Name" + _year + _faculty),
            Container(child: Text("Bio: "),padding: EdgeInsets.fromLTRB(0, 20, 320, 0),),
            Text(_bioController.text),
            Container(child: Text("Interests: "),padding: EdgeInsets.fromLTRB(0, 50, 290, 0),),
            ListView.builder(
                padding: EdgeInsets.only(left: 20),
// scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: _activities.length,
                itemBuilder: (context, index) {
                  return chipList();
                }
            ),
          ]);
    }
    else {
      return Text("Error");
    }
    })
    ));
  }
}



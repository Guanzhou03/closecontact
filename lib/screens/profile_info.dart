import 'package:flutter/material.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';
import 'package:close_contact/firestore/info-getter.dart';
import 'package:close_contact/screens/chat_requests.dart';
import '../firestore/info-setter.dart';
import '../widgets/action_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileInfo extends StatelessWidget {
  final String UID;
  final User user;
  ProfileInfo(this.user, this.UID, {Key? key}) : super(key: key);

  static List _activities = ["Running, Climbing"];
  TextEditingController _bioController = TextEditingController();
  TextEditingController _facultyController = TextEditingController();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _areaController = TextEditingController();

  var imageUrl = " ";
  Future<void> setControllers() async {
    String name = await InfoGetter.nameGetter(userID: UID);
    _nameController.text = name;
    var area = await InfoGetter.areaGetter(userID: UID);
    _areaController.text = area;
    var gender = await InfoGetter.genderGetter(userID: UID);
    _genderController.text = gender;
    var bio = await InfoGetter.bioGetter(userID: UID);
    _bioController.text = bio;
    var faculty = await InfoGetter.facultyGetter(userID: UID);
    _facultyController.text = faculty;
    var year = await InfoGetter.yearGetter(userID: UID);
    _yearController.text = year;
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

  Widget chipList() {
    return Wrap(
        spacing: 3.0,
        children: _activities.map((interest) => _buildChip(interest)).toList());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("User Info")),
        body: FutureBuilder(
            future: setControllers(),
            builder: ((context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.connectionState == ConnectionState.done) {
                return Column(children: [
                  UserProfileAvatar(
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
                  Text(_nameController.text +
                      ", " +
                      _yearController.text +
                      " " +
                      _facultyController.text, style: TextStyle(fontSize: 15)),
                  Container(
                    child: Text("Bio: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    padding: EdgeInsets.fromLTRB(0, 20, 340, 0),
                  ),
                  Container(
                    child: Text(_bioController.text),
                    padding: EdgeInsets.fromLTRB(0, 0, 190, 0),
                  ),
                  Container(
                    child: Text("Gender: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    padding: EdgeInsets.fromLTRB(0, 20, 310, 0),
                  ),
                  Container(
                    child: Text(_genderController.text),
                    padding: EdgeInsets.fromLTRB(0, 0, 190, 0),
                  ),
                  Container(
                    child: Text("Location: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    padding: EdgeInsets.fromLTRB(5, 20, 305, 0),
                  ),
                  Container(
                    child: Text(_areaController.text),
                    padding: EdgeInsets.fromLTRB(0, 0, 190, 0),
                  ),
                  Container(
                    child: Text("Interests: ",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17)),
                    padding: EdgeInsets.fromLTRB(0, 20, 300, 0),
                  ),

                  ListView.builder(
                      padding: EdgeInsets.only(left: 20),
// scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return chipList();
                      }),
                  Container //container for padding
                    (child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ActionButtonWidget(
                        onPressed: () async {
                          await InfoSetter.setCurrConvo(
                              userid: user.uid,
                              newConvo: UID);
                          await InfoSetter.setCurrConvo(
                              userid: UID,
                              newConvo: user.uid);
                          await InfoSetter.setCurrRequests(
                              userid: user.uid,
                              oldRequest: UID);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ChatRequestPage(user)));
                        },
                        icon: const Icon(
                          Icons.add,
                          color: Colors.blueAccent,
                          size: 30
                        ),
                      ),
                      const SizedBox(width: 20),
                      ActionButtonWidget(
                        onPressed: () async {
                          await InfoSetter.setCurrRequests(
                              userid: user.uid,
                              oldRequest: UID);
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ChatRequestPage(user)));
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.only(top:30))
              ]);
              } else {
                return Text("Error");
              }
            })));
  }
}

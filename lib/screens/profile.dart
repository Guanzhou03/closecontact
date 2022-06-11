import 'package:close_contact/widgets/sports_button.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:close_contact/screens/signin.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'package:path_provider/path_provider.dart';
import 'package:close_contact/widgets/bottom_nav_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:close_contact/firestore/user_maps.dart';

class MyProfilePage extends StatefulWidget {
  User user;
  MyProfilePage(this.user, {Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => Profile(user);
}

class Profile extends State<MyProfilePage> {
  List? _myActivities;
  late String _myActivitiesResult;
  final formKey = new GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _myActivities = [];
    _myActivitiesResult = '';
  }

  _saveForm() {
    var form = formKey.currentState!;
    if (form.validate()) {
      form.save();
      setState(() {
        _myActivitiesResult = _myActivities.toString();
      });
    }
  }

  File? _image;
  User user;
  Profile(this.user);

  Future getImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);

    setState(() {
      this._image = imageTemp;
    });
  }

  static const String _title = 'Profile Screen';
  final List<String> testList = ['1', '2', '3', '4', '5'];
  var sportsTapped = false;
  FirebaseFirestore db = FirebaseFirestore.instance;
  String _faculty = "";
  String _year = "";
  String _activities = "";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          resizeToAvoidBottomInset: false,
      backgroundColor: Colors.amber[50],
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Form(
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(10),
                child: Text(
                  'My Profile',
                  style: TextStyle(
                      color: Colors.brown,
                      fontFamily: 'Murray Hill',
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w900,
                      fontSize: 40),
                ),
              ),
              Stack(alignment: Alignment.center, children: [
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
                Positioned(
                    top: 120,
                    right: 60,
                    child: Transform.scale(
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
                              child: ElevatedButton(
                                onPressed: () => getImage(),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.redAccent,
                                    shape: CircleBorder()),
                                child: Icon(
                                    Icons.camera_alt,
                                    size: 45,
                                    color: Colors.white,
                                  )),
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
                                        child: ElevatedButton(
                                            child: Icon(Icons.add,
                                                color: Colors.grey),
                                            onPressed: () => {getImage()},
                                            style: ElevatedButton.styleFrom(
                                                primary: Colors.white,
                                                padding: EdgeInsets.fromLTRB(
                                                    0, 0, 10, 0)))),
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ))
              ]),
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
                      labelStyle: TextStyle(fontSize: 13)),
                ),
              ),
              Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(1.0)
                  ),
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: MultiSelectFormField(
                  fillColor: Colors.amber[50],
                  title: Text("My Interests"),
                  autovalidate: AutovalidateMode.disabled,
                  chipBackGroundColor: Colors.blue,
                  chipLabelStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  dialogTextStyle: TextStyle(fontWeight: FontWeight.bold),
                  checkBoxActiveColor: Colors.blue,
                  checkBoxCheckColor: Colors.white,
                  dialogShapeBorder: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(12.0))),
                  validator: (value) {
                    if (value == null || value.length == 0) {
                      return 'Please select one or more options';
                    }
                    return null;
                  },
                  dataSource: [
                    {
                      "display": "Running",
                      "value": "Running",
                    },
                    {
                      "display": "Climbing",
                      "value": "Climbing",
                    },
                    {
                      "display": "Chess",
                      "value": "Chess",
                    },
                    {
                      "display": "Swimming",
                      "value": "Swimming",
                    },
                    {
                      "display": "Music",
                      "value": "Music",
                    },
                    {
                      "display": "Mahjong",
                      "value": "Mahjong",
                    },
                    {
                      "display": "Football",
                      "value": "Football",
                    },
                  ],
                  textField: 'display',
                  valueField: 'value',
                  okButtonLabel: 'OK',
                  cancelButtonLabel: 'CANCEL',
                  hintWidget: Text('Please choose one or more'),
                  initialValue: _myActivities,
                  onSaved: (value) {
                    if (value == null) return;
                    setState(() {
                      _myActivities = value;
                    });
                  },
                ),
              ),
          // Container(
          //   padding: EdgeInsets.all(8),
          //   child: ElevatedButton(
          //     child: Text('Save'),
          //     onPressed: _saveForm,
          //   ),
          // ),
          Container(
            padding: EdgeInsets.fromLTRB(15, 0, 15, 15),
            child: Text(_myActivitiesResult),
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
                        items: <String>['Computing', 'Fac2', 'Fac3', 'Fac4']
                            .map((String value) {
                          _faculty = value;
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
                      labelStyle: TextStyle(fontSize: 13)),
                ),
              ),
              Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                  child: Column(children: <Widget>[
                    const Text('Year of Study ',
                        style: TextStyle(fontSize: 14)),
                  ])),
              Container(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextFormField(
                  decoration: InputDecoration(
                      suffixIcon: DropdownButtonFormField(
                        items: <String>[
                          'Year 1',
                          'Year 2',
                          'Year 3',
                          'Year 4',
                          'Year 5'
                        ].map((String value) {
                          _year = value;
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value, textAlign: TextAlign.right),
                          );
                        }).toList(),
                        onChanged: (_) {},
                      ),
                      contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      border: OutlineInputBorder(),
                      labelText: "Year of study",
                      labelStyle: TextStyle(fontSize: 13)),
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(130, 20, 130, 0),
                height: 40,
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Save Info'),
                  style: ElevatedButton.styleFrom(primary: Colors.blue),
                  onPressed: () {
                    print("Saved");
                  },
                ),
              ),
              Container(
                margin: EdgeInsets.fromLTRB(130, 40, 130, 60),
                height: 40,
                padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                child: ElevatedButton(
                  child: const Text('Log Out'),
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  onPressed: () async {
                    db
                        .collection("users")
                        .doc(user.uid)
                        .set(UserMaps.profileMap(_faculty, _year, _activities));
                    Navigator.of(context, rootNavigator: true).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return SignIn();
                        },
                      ),
                          (_) => false,
                    );
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

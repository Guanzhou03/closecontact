import 'package:close_contact/authentication/validator.dart';
import 'package:close_contact/firestore/info-getter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:close_contact/screens/signin.dart';
import 'package:user_profile_avatar/user_profile_avatar.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:close_contact/firestore/user_maps.dart';

class MyProfilePage extends StatefulWidget {
  User user;
  MyProfilePage(this.user, {Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => ProfilePageState(user);
}

class ProfilePageState extends State<MyProfilePage> {
  final _formKey = new GlobalKey<FormState>();
  String _faculty = "";
  String _year = "";
  String _activityString = "";
  static List<String> _activities = ["Running"];
  Future<void> _future = Future(() {});
  String imageUrl = " ";
  String _gender = "Gender";
  String _area = "Area";
  ProfilePageState(this.user);
  User user;

  Future<void> setControllers() async {
    var bio = await InfoGetter.bioGetter(userID: user.uid);
    _bioController.text = bio;
    var area = await InfoGetter.areaGetter(userID: user.uid);
    _areaController.text = area;
    var gender = await InfoGetter.genderGetter(userID: user.uid);
    _genderController.text = gender;
    var faculty = await InfoGetter.facultyGetter(userID: user.uid);
    _facultyController.text = faculty;
    _faculty = faculty;
    var year = await InfoGetter.yearGetter(userID: user.uid);
    _yearController.text = year;
    _year = year;
    imageUrl = await user.photoURL == null ? " " : user.photoURL as String;
    var activities = await InfoGetter.activitiesGetter(userID: user.uid);
    _activityString = activities;
    _activities =
        activities.substring(1, activities.length - 1).split(",").map((x) {
      if (x[0] == " ") {
        return x.substring(1);
      }
      return x;
    }).toList();
  }
  TextEditingController _genderController = TextEditingController();
  TextEditingController _areaController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  TextEditingController _facultyController = TextEditingController();
  TextEditingController _yearController =
      TextEditingController(text: "Please choose your year of study");

  @override
  void initState() {
    super.initState();
    _future = setControllers();
    _facultyController.text = "Please choose a faculty";
  }

  // _saveForm() {
  //   var form = _formKey.currentState!;
  //   if (form.validate()) {
  //     form.save();
  //   }
  // }

  File? _image;

  Future getUploadImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image == null) return;
    final imageTemp = File(image.path);
    String uid = user.uid;
    Reference ref = FirebaseStorage.instance
        .ref()
        .child("profilepics")
        .child("$uid" + ".jpg");
    await ref.putFile(imageTemp);
    ref.getDownloadURL().then((value) {
      setState(() {
        this._image = imageTemp;
        imageUrl = value;
      });
    });
  }

  final List<String> testList = ['1', '2', '3', '4', '5'];
  var sportsTapped = false;
  static FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.amber[50],
        body: Padding(
          padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          child: Form(
            key: _formKey,
            child: FutureBuilder(
              future: _future,
              builder: ((context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  return ListView(
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
                          avatarUrl: imageUrl == " "
                              ? 'https://picsum.photos/id/237/5000/5000'
                              : imageUrl,
                          onAvatarTap: () {},
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
                                          onPressed: () => getUploadImage(),
                                          style: ElevatedButton.styleFrom(
                                              primary: Colors.redAccent,
                                              shape: CircleBorder()),
                                          child: Icon(
                                            Icons.camera_alt,
                                            size: 45,
                                            color: Colors.white,
                                          ),
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
                                                  color: Colors.grey
                                                      .withOpacity(0.1),
                                                  spreadRadius: 10,
                                                  blurRadius: 15,
                                                  // changes position of shadow
                                                ),
                                              ]),
                                          child: Center(
                                              child: ElevatedButton(
                                                  child: Icon(Icons.add,
                                                      color: Colors.grey),
                                                  onPressed: () =>
                                                      {getUploadImage()},
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                          primary: Colors.white,
                                                          padding: EdgeInsets
                                                              .fromLTRB(0, 0,
                                                                  10, 0)))),
                                        ),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
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
                          maxLength: 100,
                          maxLines: null,
                          controller: _bioController,
                          validator: (value) =>
                              Validator.validateBio(bio: value),
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
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(1.0)),
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: MultiSelectFormField(
                          initialValue: _activities,
                          fillColor: Colors.amber[50],
                          title: Text("My Interests"),
                          autovalidate: AutovalidateMode.disabled,
                          chipBackGroundColor: Colors.blue,
                          chipLabelStyle: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                          dialogTextStyle:
                              TextStyle(fontWeight: FontWeight.bold),
                          checkBoxActiveColor: Colors.blue,
                          checkBoxCheckColor: Colors.white,
                          dialogShapeBorder: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0))),
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return 'Please select your interests';
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
                          hintWidget: Text('Please select your interests'),
                          onSaved: (value) {
                            _activityString = value.toString();
                            if (value == null) return;
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
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(15, 10, 0, 5),
                        child: Column(
                          children: <Widget>[
                            const Text('Gender ',
                                style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: TextFormField(
                          controller: _genderController,
                          validator: (value) => Validator.validateYear(value),
                          decoration: InputDecoration(
                              suffixIcon: DropdownButtonFormField(
                                hint: Text("Choose a gender",
                                    style: TextStyle(color: Colors.black)),
                                items: <String>[
                                  'Male',
                                  'Female',
                                  'Other'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child:
                                    Text(value, textAlign: TextAlign.right),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _gender = value as String;
                                },
                              ),
                              contentPadding:
                              const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                        child: Column(
                          children: <Widget>[
                            const Text('Area',
                                style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: TextFormField(
                          controller: _areaController,
                          validator: (value) => Validator.validateYear(value),
                          decoration: InputDecoration(
                              suffixIcon: DropdownButtonFormField(
                                hint: Text("Choose your location",
                                    style: TextStyle(color: Colors.black)),
                                items: <String>[
                                  'North',
                                  'Northeast',
                                  'East',
                                  'West'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child:
                                    Text(value, textAlign: TextAlign.right),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _area = value as String;
                                },
                              ),
                              contentPadding:
                              const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(15, 5, 0, 5),
                        child: const Text(
                          'Faculty/Course of study ',
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: TextFormField(
                          controller: _facultyController,
                          validator: (value) =>
                              Validator.validateFaculty(value),
                          decoration: InputDecoration(
                              suffixIcon: DropdownButtonFormField(
                                hint: Text(_facultyController.text,
                                    style: TextStyle(color: Colors.black)),
                                items: <String>[
                                  'Computing',
                                  'FoS',
                                  'FASS',
                                  'Business',
                                  'Law',
                                  'Nursing',
                                  'Medicine',
                                  'Other'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child:
                                        Text(value, textAlign: TextAlign.right),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _faculty = value as String;
                                },
                              ),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              border: OutlineInputBorder()),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.fromLTRB(15, 0, 0, 5),
                        child: Column(
                          children: <Widget>[
                            const Text('Year of Study ',
                                style: TextStyle(fontSize: 14)),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: TextFormField(
                          controller: _yearController,
                          validator: (value) => Validator.validateYear(value),
                          decoration: InputDecoration(
                              suffixIcon: DropdownButtonFormField(
                                hint: Text(_yearController.text,
                                    style: TextStyle(color: Colors.black)),
                                items: <String>[
                                  'Year 1',
                                  'Year 2',
                                  'Year 3',
                                  'Year 4',
                                  'Year 5',
                                  'Other'
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child:
                                        Text(value, textAlign: TextAlign.right),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  _year = value as String;
                                },
                              ),
                              contentPadding:
                                  const EdgeInsets.fromLTRB(10, 0, 0, 0),
                              border: OutlineInputBorder()),
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
                            if (_formKey.currentState!.validate()) {
                              db.collection("users").doc(user.uid).update(
                                    UserMaps.profileMap(
                                      _faculty,
                                      _year,
                                      _activityString,
                                      _bioController.text,
                                      _gender,
                                      _area
                                    ),
                                  );
                              db.collection("users").doc(user.uid).set(
                                  {"imageURL": imageUrl},
                                  SetOptions(merge: true));
                              user.updatePhotoURL(imageUrl);
                            }
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
                            await FirebaseAuth.instance.signOut();
                            Navigator.of(context, rootNavigator: true)
                                .pushAndRemoveUntil(
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
                  );
                }
                return const Text("error");
              }),
            ),
          ),
        ),
      ),
    );
  }
}

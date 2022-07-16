import 'package:close_contact/firestore/info-getter.dart';
import 'package:close_contact/screens/profile.dart';
import 'package:close_contact/widgets/card_stack.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  User user;
  FilterScreen(this.user, {Key? key}) : super(key: key);

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  //index 0 = Male, index 1 = Female, index 2 = Other
  static List<bool> _gender = [true, true, true];
  //index 0 = Computing, index 1 = FoS, index 2 = FASS, index 3 = Business
  //index 4 = Law, index 5 = Nursing, index 6 = Medicine, index 7 = Other
  static List<bool> _faculty = [true, true, true, true, true, true, true, true];
  //index 0 = Year 1, index 1 = Year 2, index 2 = Year 3, index 3 = Year 4
  //index 4 = Year 5, index 5 = Other
  static List<bool> _year = [true, true, true, true, true, true];
  //index 0 = North, index 1 = Northeast, index 2 = East, index 3 = West
  //index 4 = Central
  static List<bool> _area = [true, true, true, true, true];
  //[0 - Movies, 1 - Running, 2 - Climbing, 3 - Chess, 4 - Swimming,
  //5 - Music, 6 - Mahjong, 7 - Football, 8 - Basketball, 9 - Badminton,
  //10 - Anime/Manga, 11 - None of the Above]
  static List<bool> _interests = [
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true,
    true
  ];
  FirebaseFirestore db = FirebaseFirestore.instance;
  Future<void> _future = Future(() {});

  @override
  initState() {
    print(widget.user.uid);
    super.initState();
    _future = initialise();
  }

  Future<void> initialise() async {
    var temp = InfoGetter.prefGetter(userid: widget.user.uid);
    var genderTemp = await temp.then((value) => value["gender"]);
    _gender = List<bool>.from(genderTemp);
    var facultyTemp = await temp.then((value) => value["faculty"]);
    _faculty = List<bool>.from(facultyTemp);
    var yearTemp = await temp.then((value) => value["year"]);
    _year = List<bool>.from(yearTemp);
    var areaTemp = await temp.then((value) => value["area"]);
    _area = List<bool>.from(areaTemp);
    var interestsTemp = await temp.then((value) => value["interests"]);
    _interests = List<bool>.from(interestsTemp);
  }

  Widget onOffButton(List<bool> prefList, int index, String title) {
    return prefList[index]
        ? ElevatedButton(
            child: Text(title),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.orange),
            ),
            onPressed: () {
              setState(() {
                prefList[index] = !prefList[index];
              });
            },
          )
        : ElevatedButton(
            child: Text(title),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
            onPressed: () {
              setState(() {
                prefList[index] = !prefList[index];
              });
            },
          );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: ((context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }
        if (snapshot.connectionState == ConnectionState.done) {
          print(_gender);
          return Scaffold(
            appBar: AppBar(
              leading: BackButton(
                  color: Colors.black,
                  onPressed: () => Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                            builder: (context) => MyProfilePage(widget.user)),
                      )),
              backgroundColor: Colors.amber[50],
              title: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "Set Your Preferences",
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                  ],
                ),
              ),
            ),
            body: Column(
              children: <Widget>[
                Row(
                  children: [
                    onOffButton(_gender, 0, "Male"),
                    onOffButton(_gender, 1, "Female"),
                    onOffButton(_gender, 2, "Other"),
                  ],
                ),
                Row(
                  children: [
                    onOffButton(_faculty, 0, "Computing"),
                    onOffButton(_faculty, 1, "FoS"),
                    onOffButton(_faculty, 2, "FASS"),
                    onOffButton(_faculty, 3, "Business"),
                  ],
                ),
                Row(
                  children: [
                    onOffButton(_faculty, 4, "Law"),
                    onOffButton(_faculty, 5, "Nursing"),
                    onOffButton(_faculty, 6, "Medicine"),
                    onOffButton(_faculty, 7, "Other"),
                  ],
                ),
                Row(
                  children: [
                    onOffButton(_year, 0, "Year 1"),
                    onOffButton(_year, 1, "Year 2"),
                    onOffButton(_year, 2, "Year 3"),
                  ],
                ),
                Row(
                  children: [
                    onOffButton(_year, 3, "Year 4"),
                    onOffButton(_year, 4, "Year 5"),
                    onOffButton(_year, 5, "Other"),
                  ],
                ),
                Row(
                  children: [
                    onOffButton(_area, 0, "North"),
                    onOffButton(_area, 1, "South"),
                    onOffButton(_area, 2, "East"),
                    onOffButton(_area, 3, "West"),
                    onOffButton(_area, 4, "Central"),
                  ],
                ),
                Row(
                  children: [
                    onOffButton(_interests, 0, "Movies"),
                    onOffButton(_interests, 1, "Running"),
                    onOffButton(_interests, 2, "Climbing"),
                    onOffButton(_interests, 3, "Chess"),
                  ],
                ),
                Row(
                  children: [
                    onOffButton(_interests, 4, "Swimming"),
                    onOffButton(_interests, 5, "Music"),
                    onOffButton(_interests, 6, "Mahjong"),
                    onOffButton(_interests, 7, "Football"),
                  ],
                ),
                Row(
                  children: [
                    onOffButton(_interests, 8, "Basketball"),
                    onOffButton(_interests, 9, "Badminton"),
                    onOffButton(_interests, 10, "Anime/Manga"),
                    onOffButton(_interests, 11, "None"),
                  ],
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(130, 20, 130, 0),
                  height: 40,
                  padding: const EdgeInsets.fromLTRB(0, 0, 10, 0),
                  child: ElevatedButton(
                    child: const Text('Save Info'),
                    style: ElevatedButton.styleFrom(primary: Colors.blue),
                    onPressed: () async {
                      await db
                          .collection("users")
                          .doc(widget.user.uid)
                          .collection("preferences")
                          .doc("preferences")
                          .set({
                        "gender": _gender,
                        "faculty": _faculty,
                        "year": _year,
                        "area": _area,
                        "interests": _interests
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return Text("ERROR");
      }),
    );
  }
}

import 'package:close_contact/algorithm/recommendation-algo.dart';
import 'package:close_contact/firestore/info-getter.dart';
import 'package:close_contact/firestore/info-setter.dart';
import 'package:close_contact/firestore/user_maps.dart';
import 'package:close_contact/screens/home.dart';
import 'package:close_contact/widgets/profile_card.dart';
import 'package:close_contact/widgets/action_button.dart';
import 'package:close_contact/widgets/swipe.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CardsStackWidget extends StatefulWidget {
  CardsStackWidget({Key? key}) : super(key: key);

  @override
  State<CardsStackWidget> createState() => CardsStackWidgetState();
}

class CardsStackWidgetState extends State<CardsStackWidget>
    with SingleTickerProviderStateMixin {
  static FirebaseAuth auth = FirebaseAuth.instance;
  static final FirebaseFirestore db = FirebaseFirestore.instance;
  static User? _user = FirebaseAuth.instance.currentUser;
  static List<Profile> draggableItems = [];
  static List<String> userIdList = [];
  static List<String> _seenUsers = [];
  Future<void> _future = Future(() {});

  ValueNotifier<Swipe> swipeNotifier = ValueNotifier(Swipe.none);
  late final AnimationController _animationController;

  Future<void> checkForChanges() async {
    await loadProfiles();
    DocumentReference userInterests = db.collection('users').doc(_user!.uid);
    userInterests.snapshots().listen((querySnapshot) {
      loadProfiles();
    });
    CollectionReference userPreferences =
        db.collection('users').doc(_user!.uid).collection("preferences");
    userPreferences.snapshots().listen((querySnapshot) {
      querySnapshot.docChanges.forEach((change) {
        loadProfiles();
      });
    });
  }

  Future<void> loadProfiles() async {
    print("Profiles loaded");
    await auth.authStateChanges().listen((User? user) {
      _user = user;
    });
    try {
      var temp = await InfoGetter.cardStackCreator(user: _user);
      var seenUsers = await InfoGetter.seenUsersGetter(userID: _user!.uid);
      print("seen users are: " + seenUsers.toString());
      var temp1 =
          await RecommendationAlgo().sortProfiles(temp, _user!, seenUsers);
      var temp2 = await InfoGetter.userIdListGetter(profileList: temp1);
      setState(() {
        draggableItems = temp1;
        _seenUsers = seenUsers;
        print(temp1);
        userIdList = temp2;
        print(temp2);
      });
    } catch (e) {
      print(e);
    }
  }

  static Future<void> removeLast() async {
    // if (draggableItems.length == 2) {
    //   var temp = await InfoGetter.cardStackCreator(user: user);
    //   draggableItems.addAll(temp);
    // } else {
    draggableItems.removeLast();
    //}
  }

  @override
  void initState() {
    _future = checkForChanges();
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        removeLast();
        _animationController.reset();
        swipeNotifier.value = Swipe.none;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            return Stack(
              clipBehavior: Clip.none,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: ValueListenableBuilder(
                    valueListenable: swipeNotifier,
                    builder: (context, swipe, _) => Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: List.generate(draggableItems.length, (index) {
                        if (index == draggableItems.length - 1) {
                          return PositionedTransition(
                            rect: RelativeRectTween(
                              begin: RelativeRect.fromSize(
                                  const Rect.fromLTWH(0, 0, 580, 340),
                                  const Size(580, 340)),
                              end: RelativeRect.fromSize(
                                  Rect.fromLTWH(
                                      swipe != Swipe.none
                                          ? swipe == Swipe.left
                                              ? -300
                                              : 300
                                          : 0,
                                      0,
                                      580,
                                      340),
                                  const Size(580, 340)),
                            ).animate(CurvedAnimation(
                              parent: _animationController,
                              curve: Curves.easeInOut,
                            )),
                            child: RotationTransition(
                              turns: Tween<double>(
                                      begin: 0,
                                      end: swipe != Swipe.none
                                          ? swipe == Swipe.left
                                              ? -0.1 * 0.3
                                              : 0.1 * 0.3
                                          : 0.0)
                                  .animate(
                                CurvedAnimation(
                                  parent: _animationController,
                                  curve: const Interval(0, 0.4,
                                      curve: Curves.easeInOut),
                                ),
                              ),
                              child: DragWidget(
                                profile: draggableItems[index],
                                index: index,
                                swipeNotifier: swipeNotifier,
                                isLastCard: true,
                              ),
                            ),
                          );
                        } else {
                          return DragWidget(
                            profile: draggableItems[index],
                            index: index,
                            swipeNotifier: swipeNotifier,
                          );
                        }
                      }),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ActionButtonWidget(
                          onPressed: () {
                            swipeNotifier.value = Swipe.left;
                            _animationController.forward();
                          },
                          icon: const Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 20),
                        ActionButtonWidget(
                          onPressed: () {
                            swipeNotifier.value = Swipe.right;
                            _animationController.forward();
                          },
                          icon: const Icon(
                            Icons.favorite,
                            color: Colors.red,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  child: DragTarget<int>(
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return IgnorePointer(
                        child: Container(
                          height: 700.0,
                          width: 80.0,
                          color: Colors.transparent,
                        ),
                      );
                    },
                    onAccept: (int index) async {
                      await InfoSetter.setSeenUsers(
                          currUser: _user!.uid,
                          userid: userIdList[index],
                          seenUsers: _seenUsers);
                      setState(() {
                        removeLast();
                        //draggableItems.removeAt(index);
                      });
                    },
                  ),
                ),
                Positioned(
                  right: 0,
                  child: DragTarget<int>(
                    builder: (
                      BuildContext context,
                      List<dynamic> accepted,
                      List<dynamic> rejected,
                    ) {
                      return IgnorePointer(
                        child: Container(
                          height: 700.0,
                          width: 80.0,
                          color: Colors.transparent,
                        ),
                      );
                    },
                    onAccept: (int index) async {
                      var currUserId = userIdList[index];
                      await InfoSetter.setSeenUsers(
                          currUser: _user!.uid,
                          userid: currUserId,
                          seenUsers: _seenUsers);
                      var snapshot = await db
                          .collection("users")
                          .doc(currUserId)
                          .collection("requests")
                          .doc("incoming");
                      var currUserInfo =
                          await db.collection("users").doc(_user!.uid).get();
                      var currMap = currUserInfo.data();
                      var bool = currMap!.containsKey("Name") &&
                          currMap.containsKey("imageURL") &&
                          currMap["imageURL"] != " " &&
                          currMap.containsKey("userid") &&
                          currMap.containsKey("Email") &&
                          currMap.containsKey("bio") &&
                          currMap.containsKey("year") &&
                          currMap.containsKey("activities") &&
                          currMap.containsKey("faculty");
                      try {
                        if (!bool) {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: Text(
                                  "Please complete your profile before swiping!"),
                            ),
                          );
                          return null;
                        }

                        List<String>? idList =
                            await InfoGetter.currIncoming(userid: currUserId);
                        List<String> currConvo =
                            await InfoGetter.currConvoGetter(
                                userid: currUserId);
                        print(currUserId);
                        print(_user!.uid);
                        if (idList.isEmpty) {
                          if (currConvo.isEmpty ||
                              !currConvo.contains(_user!.uid)) {
                            snapshot.set({
                              "incoming": [_user!.uid],
                            });
                          }
                        } else {
                          if (!idList.contains(_user!.uid)) {
                            if (currConvo.isEmpty ||
                                !currConvo.contains(_user!.uid)) {
                              snapshot.set(
                                  UserMaps.incomingRequest(_user!.uid, idList));
                            }
                          }
                        }
                      } catch (e) {
                        print(e);
                      }
                      setState(() {
                        removeLast();
                      });
                    },
                  ),
                ),
              ],
            );
          }
        });
  }
}

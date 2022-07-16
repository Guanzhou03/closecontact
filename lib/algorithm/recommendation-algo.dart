import 'package:close_contact/firestore/info-getter.dart';
import 'package:close_contact/widgets/profile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RecommendationAlgo {
  double calculateSimilarity(
      List<String> interests, List<String> userInterests) {
    double count = 1.0;
    interests.forEach((curr) => {
          if (userInterests.contains(curr)) {count += 1.0}
        });
    return count / userInterests.length;
  }

  List<String> getList(String interests) {
    return interests.substring(1, interests.length - 1).split(",").map((x) {
      return x.trim();
    }).toList();
  }

  Future<List<Profile>> sortProfiles(
      List<Profile> userList, User user, List<String> seenUsers) async {
    String userInterestsString =
        await InfoGetter.activitiesGetter(userID: user.uid);
    List<String> userInterests = getList(userInterestsString);
    //filter profiles that has not been seen
    userList = userList
        .where((element) => !seenUsers.contains(element.userid))
        .toList();
    //sort based on similarity
    userList.sort((a, b) => calculateSimilarity(
            getList(a.interests), userInterests)
        .compareTo(calculateSimilarity(getList(b.interests), userInterests)));
    return userList;
  }
}

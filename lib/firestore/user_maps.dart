class UserMaps {
  static Map<String, dynamic> registerMap(
      String userid, String name, String email) {
    return {
      "userid": userid,
      "Name": name,
      "Email": email,
    };
  }

  static Map<String, dynamic> profileMap(
      String faculty, String year, String activities, String bio) {
    return {
      "faculty": faculty,
      "year": year,
      "activities": activities,
      "bio": bio,
    };
  }
}

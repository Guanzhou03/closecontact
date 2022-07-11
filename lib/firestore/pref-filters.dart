class PrefFilters {
  static bool filterGender(String gender, List<bool> genderList) {
    if (gender == "Male") {
      return genderList[0] == true;
    } else if (gender == "Female") {
      return genderList[1] == true;
    } else {
      return genderList[2] == true;
    }
  }
}

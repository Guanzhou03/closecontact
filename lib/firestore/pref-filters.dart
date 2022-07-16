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

  static bool filterFaculty(String faculty, List<bool> facultyList) {
    if (faculty == "Computing") {
      return facultyList[0] == true;
    } else if (faculty == "FoS") {
      return facultyList[1] == true;
    } else if (faculty == "FASS") {
      return facultyList[2] == true;
    } else if (faculty == "Business") {
      return facultyList[3] == true;
    } else if (faculty == "Law") {
      return facultyList[4] == true;
    } else if (faculty == "Nursing") {
      return facultyList[5] == true;
    } else if (faculty == "Medicine") {
      return facultyList[6] == true;
    } else {
      return facultyList[7] == true;
    }
  }

  static bool filterYear(String year, List<bool> yearList) {
    if (year == "Year 1") {
      return yearList[0];
    } else if (year == "Year 2") {
      return yearList[1];
    } else if (year == "Year 3") {
      return yearList[2];
    } else if (year == "Year 4") {
      return yearList[3];
    } else if (year == "Year 5") {
      return yearList[4];
    } else {
      return yearList[5];
    }
  }

  static bool filterArea(String area, List<bool> areaList) {
    if (area == "North") {
      return areaList[0];
    } else if (area == "South") {
      return areaList[1];
    } else if (area == "East") {
      return areaList[2];
    } else if (area == "West") {
      return areaList[3];
    } else {
      return areaList[4];
    }
  }

  // this interest corresponds to the "activities" string in Cloud Firestore
  static bool filterInterests(String interest, List<bool> interestList) {
    var temp = interest
        .substring(1, interest.length - 1)
        .split(',')
        .map((x) => x.trim())
        .toList();
    for (String s in temp) {
      if (filterIndivInterests(s, interestList)) return true;
    }
    return false;
  }
}

//this interest corresponds to each interest,
//stored under the "activities" string
bool filterIndivInterests(String interest, List<bool> interestList) {
  if (interest == "Movies") {
    return interestList[0];
  } else if (interest == "Running") {
    return interestList[1];
  } else if (interest == "Climbing") {
    return interestList[2];
  } else if (interest == "Chess") {
    return interestList[3];
  } else if (interest == "Swimming") {
    return interestList[4];
  } else if (interest == "Music") {
    return interestList[5];
  } else if (interest == "Mahjong") {
    return interestList[6];
  } else if (interest == "Football") {
    return interestList[7];
  } else if (interest == "Basketball") {
    return interestList[8];
  } else if (interest == "Badminton") {
    return interestList[9];
  } else if (interest == "Anime/Manga") {
    return interestList[10];
  } else {
    return interestList[11];
  }
}

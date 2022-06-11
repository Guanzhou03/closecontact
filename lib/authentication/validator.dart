class Validator {
  static String? validateName({required String? name}) {
    if (name == null) {
      return null;
    }
    if (name.isEmpty) {
      return 'Name can\'t be empty';
    }

    return null;
  }

  static String? validateEmail({required String? email}) {
    if (email == null) {
      return null;
    }
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@([u]+(\.[nus]+)+(\.[edu]+))*$");

    if (email.isEmpty) {
      return 'Email can\'t be empty';
    } else if (!emailRegExp.hasMatch(email)) {
      return 'Please enter a valid NUS email!';
    }

    return null;
  }

  static String? validatePassword({required String? password}) {
    if (password == null) {
      return null;
    }
    if (password.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password.length < 6) {
      return 'Enter a password with length at least 6';
    }

    return null;
  }

  static String? validatePasswordSame(
      {required String? password1, required String? password2}) {
    if (password2 == null) {
      return null;
    }
    if (password2.isEmpty) {
      return 'Password can\'t be empty';
    } else if (password1 != password2) {
      return 'The 2 passwords are not the same!';
    }

    return null;
  }

  static String? validateBio({required String? bio}) {
    if (bio == null) {
      return null;
    }
    if (bio.isEmpty) {
      return "Bio can\'t be empty";
    }
    return null;
  }

  static String? validateFaculty(String? faculty) {
    if (faculty == null) {
      return "Please select your faculty!";
    }
    return null;
  }

  static String? validateYear(String? year) {
    if (year == null) {
      return "Please select your year!";
    }
    return null;
  }
}

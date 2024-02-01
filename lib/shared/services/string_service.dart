class StringService {
  // TODO: add custom validator

  String? emptyEmailValidator(String? value) {
    if (value!.trim().isEmpty) {
      return 'Email can not be empty.';
    }
    if (!value.contains('@')) {
      return "invalid email format.";
    } else {
      return null;
    }
  }

  String? emptyPasswordValidator(String? value) {
    if (value!.trim().isEmpty) {
      return 'Password can not be empty.';
    }

    return null;
  }

  String? userNameValidator(String? value) {
    if (value!.length < 4) {
      return 'Username must be at least 4 characters.';
    }
    if (value.contains(RegExp(r'[^A-Za-z0-9]'))) {
      return 'Username can not contain special characters or spaces.';
    }
    return null;
  }

  // TODO: refactor
  String? passwordValidator(String? value) {
    if (value!.length < 7) {
      return 'Password must be at least 7 characters long.';
    }
    if (!value.contains(RegExp(r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$"))) {
      return r"""

Password Requirements:

  At least one:
    - digit
    - lowercase character
    - least uppercase character
    - least special character
  
  - least 8 - 32 characters in length.

""";
    }
    return null;
  }
}

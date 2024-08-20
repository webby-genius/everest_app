mixin Validators {
  String? validateEmailForm(String? email) {
    if ((email ?? "").trim().isEmpty) return "Email can't be empty";
    return validateEmail(email ?? "") ? null : "Enter a valid email";
  }

  validateEmail(String? email) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern.toString());
    if (!regex.hasMatch(email!.trim())) {
      return false;
    } else {
      return true;
    }
  }

  isStrongPassword(String? password) {
    // At least 8 characters
    if (password!.length < 8) {
      return false;
    }
    // // Contains at least one uppercase letter
    // if (!password.contains(RegExp(r'[A-Z]'))) {
    //   return false;
    // }
    // // Contains at least one lowercase letter
    // if (!password.contains(RegExp(r'[a-z]'))) {
    //   return false;
    // }
    // // Contains at least one digit
    // if (!password.contains(RegExp(r'[0-9]'))) {
    //   return false;
    // }
    // // Contains at least one special character
    // if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
    //   return false;
    // }
    return true;
  }

  String? validateIsStrongPassword(String? password) {
    if ((password ?? "").trim().isEmpty) {
      return "Password can't be empty";
    } else if ((password ?? "").trim().length < 4 || (password ?? "").trim().length > 20) {
      // Check if the password is within the 8-20 character limit
      return "Password must be 5-20 characters long";
    }
    return null;
  }

  String? userName(String? userName) {
    if ((userName ?? '').trim().isEmpty) {
      return "*Enter User Name";
    }
    return null;
  }

  String? mobilePhone(String? mobilePhone) {
    if ((mobilePhone ?? '').trim().isEmpty) {
      return "*Enter Phone Number ";
    } else if (mobilePhone!.length < 10) {
      return "*Enter 10 Digit Company Number ";
    }
    return null;
  }

  String? zipCodeValidation(String? zipCode) {
    if ((zipCode ?? '').trim().isEmpty) {
      return "*Enter Zip Code ";
    } else if (zipCode!.length < 6) {
      return "*Enter 6 Digit Code ";
    }
    return null;
  }
}

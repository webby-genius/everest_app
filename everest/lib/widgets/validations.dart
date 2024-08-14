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
    // Contains at least one uppercase letter
    if (!password.contains(RegExp(r'[A-Z]'))) {
      return false;
    }
    // Contains at least one lowercase letter
    if (!password.contains(RegExp(r'[a-z]'))) {
      return false;
    }
    // Contains at least one digit
    if (!password.contains(RegExp(r'[0-9]'))) {
      return false;
    }
    // Contains at least one special character
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return false;
    }
    return true;
  }

  String? validateIsStrongPassword(String? password) {
    if ((password ?? "").trim().isEmpty) {
      return "Password can't be empty";
    } else if ((password ?? "").trim().length < 8) {
      return isStrongPassword(password ?? "")
          ? null
          : """It should contain at least 8 characters, an uppercase letter, a lowercase letter, a digit, and a special character (!@#\$%^&*(),.?":{}|<>). It should not contain any invalid characters.""";
    }
    return null;
  }

  String? invoiceNumberName(String? invoiceNumber) {
    if ((invoiceNumber ?? '').trim().isEmpty) {
      return "*Enter Invoice Number";
    }
    return null;
  }

  String? businessName(String? itemName) {
    if ((itemName ?? '').trim().isEmpty) {
      return "*Enter Business Name";
    }
    return null;
  }
    String? businessEmail(String? itemEmail) {
    if ((itemEmail ?? '').trim().isEmpty) {
      return "*Enter Business Email";
    }
    return null;
  }

  String? clientName(String? itemName) {
    if ((itemName ?? '').trim().isEmpty) {
      return "*Enter Client Name";
    }
    return null;
  }

  String? clientEmail(String? itemEmail) {
    if ((itemEmail ?? '').trim().isEmpty) {
      return "*Enter Client Email";
    }
    return null;
  }

  String? itemName(String? itemName) {
    if ((itemName ?? '').trim().isEmpty) {
      return "*Enter Item Name";
    }
    return null;
  }

  String? itemPrice(String? itemPrice) {
    if ((itemPrice ?? '').trim().isEmpty) {
      return "*Enter Item Price";
    }
    return null;
  }
  String? itemQuantity(String? itemQuantity) {
    if ((itemQuantity ?? '').trim().isEmpty) {
      return "*Enter Item Quantity";
    }
    return null;
  }

  String? itemDescription(String? itemDescription) {
    if ((itemDescription ?? '').trim().isEmpty) {
      return "*Enter Item Description";
    }
    return null;
  }

  String? lastName(String? lastName) {
    if ((lastName ?? '').trim().isEmpty) {
      return "*Enter last Name";
    }
    return null;
  }

  String? firstName(String? firstName) {
    if ((firstName ?? '').trim().isEmpty) {
      return "*Enter first Name";
    }
    return null;
  }

  String? cityName(String? cityName) {
    if ((cityName ?? '').trim().isEmpty) {
      return "*Enter city";
    }
    return null;
  }

  String? zipName(String? zipName) {
    if ((zipName ?? '').trim().isEmpty) {
      return "*Enter zipcode";
    }
    return null;
  }

  String? addressValidation(String? addressValidation) {
    if ((addressValidation ?? '').trim().isEmpty) {
      return "*Enter Address";
    }
    return null;
  }

  String? taxIdName(String? textIdName) {
    if ((textIdName ?? '').trim().isEmpty) {
      return "*Enter tax Id ";
    }
    return null;
  }

  String? signatureName(String? signatureName) {
    if ((signatureName ?? '').trim().isEmpty) {
      return "*Enter Signature Name";
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

  String? companyName(String? companyName) {
    if ((companyName ?? '').trim().isEmpty) {
      return "*Enter Company Name";
    }
    return null;
  }

  String? clentName(String? schoolName) {
    if ((schoolName ?? '').trim().isEmpty) {
      return "*Enter Client Name";
    }
    return null;
  }

  String? bussinessName(String? soldBussinessName) {
    if ((soldBussinessName ?? '').trim().isEmpty) {
      return "*Enter Bussiness Name";
    }
    return null;
  }
}


class TValidator{

  // Empty text validation
  static String? validateEmptyText(String? fieldName, String? value) {
    if(value == null || value.isEmpty) {
      return '$fieldName is Required';
    }

    return null;
  }
  static String? validateEmail(String? value) {
    if(value == null || value.isEmpty) {
      return 'Email is Required';
    }

    // Regular Expression for Email Validation
    final emailRegExp = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');

    if(!emailRegExp.hasMatch(value)) {
      return 'Invalid Email Address.';
    }

    return null;
  }

  static String? validatePassword(String? value) {
    if(value == null || value.isEmpty) {
      return 'Password is Required';
    }

    // Check for Minimum Password Length
    if(value.length < 6) {
      return 'Password must be atleast 6 characters long.';
    }

    //Check for uppercase letter
    if(!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain atleast one uppercase letter';
    }

    // Check for number
    if(!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain atleast one number';
    }

    // Check for Special Character
    if(!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Passsword must conttain at least one special character';
    }

    return null;
  }

  static String? validatePhoneNumber(String? value) {
    if(value == null || value.isEmpty) {
      return 'Phone Number is Requoired';
    }

    // Regular Expression for Phone Number Validation
    final phoneRegExp = RegExp('^(?:[+0]9)?[0-9]{10}');

    if(!phoneRegExp.hasMatch(value)) {
      return 'Invalid Phone Number Format';
    }

    return null;
  }
}

// r'^\d{10$}'
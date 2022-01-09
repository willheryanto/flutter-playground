String? validateUsername(String? value) {
  RegExp regex = RegExp(
      r'^(?=.{4,20}$)(?![_.])(?!.*[_.]{2})[a-zA-Z0-9._]+(?<![_.])$'); //r'^[a-zA-Z0-9]{6,20}$');
  if (value == null || value.isEmpty) {
    return "Username is empty";
  } else if (!regex.hasMatch(value)) {
    return "Username is 8-20 characters long and alphanumeric";
  }
  return null;
}

String? validatePassword(String? value) {
  RegExp regex = RegExp(
      r'^(?=.*[A-Za-z])(?=.*\d)[A-Za-z\d]{8,}$'); //r'^[a-zA-Z0-9]{6,20}$');
  if (value == null || value.isEmpty) {
    return "Password is empty";
  } else if (!regex.hasMatch(value)) {
    return "Password minimum 8 characters, at least 1 letter and 1 number";
  }
  return null;
}

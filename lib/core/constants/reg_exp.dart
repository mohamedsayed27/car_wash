class RegularExp{
  static RegExp passwordRegex = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{6,}$');
  static RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  static RegExp phoneRegExp = RegExp(r'^((?:[+?0?0?966]+)(?:\s?\d{2})(?:\s?\d{7}))$');
}
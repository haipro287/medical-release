class CommonFunction {
  static String convertLongString(
      {required String string,
      required int firstLength,
      required int lastLength}) {
    if (string.length < firstLength) return string;
    var firstPattern = string.toString().substring(0, firstLength);
    var secondPattern =
        string.toString().substring(string.length - lastLength, string.length);
    return firstPattern + '...' + secondPattern;
  }
}

String convertLongString(
    {required String string,
    required int firstLength,
    required int lastLength}) {
  if (string.length <= firstLength) return string;
  if (firstLength + lastLength >= string.length) return string;
  var firstPattern = string.toString().substring(0, firstLength);
  var secondPattern = string.toString().substring(
      string.length - lastLength > firstLength
          ? string.length - lastLength
          : firstLength + 1,
      string.length);
  return firstPattern + '...' + secondPattern;
}

String getWithoutSpaces(String s) {
  String tmp = s.substring(0, s.length);
  while (tmp.startsWith(' ')) {
    tmp = tmp.substring(1);
  }
  while (tmp.endsWith(' ')) {
    tmp = tmp.substring(0, tmp.length - 1);
  }
  return tmp;
}

String getHintText(dynamic userData) {
  if (userData["romanji"] != null && userData["kanji"] != null) {
    return userData["kanji"] + " (" + userData["romanji"] + ")";
  }
  return "佐藤桜(Sato Sakura)";
}

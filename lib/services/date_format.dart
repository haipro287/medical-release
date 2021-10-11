import 'dart:core';

import 'package:intl/intl.dart';
import 'package:medical_chain_mobile_ui/models/GMT.dart';

class TimeService {
  static DateTime? stringToDateTime(int dateTime) {
    if (dateTime == null) return null;
    DateTime temp = DateTime.fromMicrosecondsSinceEpoch(dateTime * 1000);
    DateTime time = temp
        .add(Duration(hours: GMT.getGMT().hour, minutes: GMT.getGMT().minute));
    return time;
  }

  static DateTime stringToDateTime3(String dateTime) {
    return DateTime.now();
  }

  static Future<String?> timeNoti(String dateTime) async {
    if (dateTime == null) return null;
    return "time";
  }

  static String dateTimeToString(DateTime dateTime) {
    return DateFormat("yyyy-MM-dd HH:mm:ss").format(dateTime);
  }

  static String dateTimeToString2(DateTime dateTime) {
    DateTime time = dateTime.subtract(
        Duration(hours: GMT.getGMT().hour, minutes: GMT.getGMT().minute));
    return DateFormat("HH:mm:ss dd-MM-yyyy").format(time);
  }

  static String dateTimeToString3(DateTime dateTime) {
    return DateFormat("HH:mm:ss dd-MM-yyyy").format(dateTime);
  }

  static String dateTimeToString4(DateTime dateTime) {
    return DateFormat("yyyy'年'MM'月'dd'日'").format(dateTime);
  }

  static String timeNowToString() {
    return DateTime.now().toString();
  }

  static int? timeToBackEnd(DateTime dateTime) {
    if (dateTime == null) return null;
    // DateTime beTime = dateTime.subtract(
    //     Duration(hours: GMT.getGMT().hour, minutes: GMT.getGMT().minute));
    var datedFormat = dateTime.toUtc().millisecondsSinceEpoch;
    return datedFormat;
  }

  static int? timeToBackEndMaster(DateTime dateTime) {
    if (dateTime == null) return null;
    var datedFormat = dateTime.toUtc().millisecondsSinceEpoch;
    print({"dateFormat": datedFormat});
    return datedFormat;
  }

  static String stringToDJP(DateTime dateTime) {
    var datedFormat = DateFormat("yyyy/MM/dd HH:mm").format(dateTime);
    return datedFormat;
  }

  static DateTime getTimeNow() {
    return new DateTime.now();
  }

  static DateTime? getDayNow() {
    DateTime timeNow = DateTime.now();
    String datedFormat = DateFormat("yyyy-MM-dd").format(timeNow);
    return DateTime.tryParse(datedFormat);
  }

  static String getTimeFormat(String time, String suffix) {
    DateTime dateTime = DateTime.parse(time);
    var datedFormat = DateFormat("yyyy/MM/dd HH:mm$suffix").format(dateTime);
    return datedFormat;
  }
}

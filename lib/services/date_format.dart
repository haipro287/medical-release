import 'dart:core';

import 'package:intl/intl.dart';
import 'package:medical_chain_mobile_ui/models/GMT.dart';

class TimeService {
  static DateTime? stringToDateTime(String dateTime) {
    if (dateTime == null) return null;
    DateTime temp = DateTime.parse(dateTime);
    DateTime time = temp
        .add(Duration(hours: GMT.getGMT().hour, minutes: GMT.getGMT().minute));
    return time;
  }

  static DateTime? stringToDateTime2(String dateTime) {
    if (dateTime == null) return null;
    DateTime temp = DateTime.parse(dateTime);

    return temp;
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

  static String timeNowToString() {
    return DateTime.now().toString();
  }

  static String? timeToBackEnd(DateTime dateTime) {
    if (dateTime == null) return null;
    DateTime beTime = dateTime.subtract(
        Duration(hours: GMT.getGMT().hour, minutes: GMT.getGMT().minute));
    var datedFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss'Z'").format(beTime);
    return datedFormat;
  }

  static String? timeToBackEndMaster(DateTime dateTime) {
    DateTime a = DateTime.now();
    print({"8601": a.toIso8601String()});
    if (dateTime == null) return null;
    var datedFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.ms'Z'").format(dateTime);
    print({"dateFormat": datedFormat});
    return datedFormat;
  }

  static String? dateTimeToDMY(DateTime dateTime) {
    if (dateTime == null) return null;
    return DateFormat("dd-MM-yyyy").format(dateTime);
  }

  static String? dateTimeToDMYver2(DateTime dateTime) {
    if (dateTime == null) return null;
    return DateFormat("dd/MM/yyyy").format(dateTime);
  }

  static String? stringToDMY(String dateTime) {
    if (dateTime == null) return null;
    var dated = DateTime.parse(dateTime);
    var datedFormat = DateFormat("dd/MM/yyyy").format(dated);
    return datedFormat;
  }

  static String? stringToDMYHMGMT(String dateTime) {
    if (dateTime == null) return null;
    var dated = DateTime.parse(dateTime);
    DateTime time = dated
        .add(Duration(hours: GMT.getGMT().hour, minutes: GMT.getGMT().minute));
    var datedFormat = DateFormat("dd/MM/yyyy HH:mm").format(time);
    return datedFormat;
  }

  static String stringToDMYHM(String dateTime) {
    var dated = DateTime.parse(dateTime);
    var datedFormat = DateFormat("dd/MM/yyyy HH:mm").format(dated);
    return datedFormat;
  }

  static String stringToDJP(DateTime dateTime) {
    var datedFormat = DateFormat("yyyy/MM/dd HH:mm'まで'").format(dateTime);
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

  static String convertAssignmentTime(String time) {
    var a = time.split(" ");
    String convertTime = a[1] + " " + a[0];
    return convertTime;
  }
}

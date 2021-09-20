import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/models/User.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_screen.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';

class GlobalController extends GetxController {
  var db;
  Rx<User> user = User().obs;
  var sharingStatus = "SENT_DATA".obs;
  var historyStatus = "SENDING_MODE".obs;
  var recordsTabMode = 0.obs;
  var itemSelected = {}.obs;
  var editToShareMode = "".obs;
  var subscription;
  String? userAgent;
  bool isPopup = false;
  var connectivityResult;

  Future<void> initActivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (user.value.username == null) {
      } else {
        if (result == ConnectivityResult.none) {
          if (isPopup == false) {
            isPopup = true;
            showDialog(
                barrierDismissible: false,
                context: Get.context!,
                barrierColor: Colors.black38,
                builder: (builder) {
                  return WillPopScope(
                    onWillPop: () async {
                      return false;
                    },
                    child: Container(
                      child: Align(
                        alignment: Alignment.center,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(
                              getWidth(5),
                            ),
                          ),
                          child: Material(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0)),
                            child: Padding(
                              padding: EdgeInsets.all(getWidth(10)),
                              child: Image.asset(
                                "assets/images/wifi.gif",
                                width: getWidth(90),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                });
          }
        } else {
          if (isPopup == true) {
            isPopup = false;
            Get.back();
          } else {
            if (connectivityResult == ConnectivityResult.none)
              Get.offAll(() => HomePageScreen());
          }
        }
      }
    });
  }

  Future<void> getInfoDevice() async {
    if (Platform.isAndroid) {
      var androidInfo = await DeviceInfoPlugin().androidInfo;
      var release = androidInfo.version.release;
      var sdkInt = androidInfo.version.sdkInt;
      var manufacturer = androidInfo.manufacturer;
      var model = androidInfo.model;
      userAgent = '$manufacturer $model;Android;Android $release';
      print(userAgent);
    }

    if (Platform.isIOS) {
      var iosInfo = await DeviceInfoPlugin().iosInfo;
      var systemName = iosInfo.systemName;
      var version = iosInfo.systemVersion;
      var name = iosInfo.name;
      var model = iosInfo.model;
      userAgent = '$name $model;$systemName;$systemName $version';
      print(userAgent);
    }
  }
}

import 'package:connectivity/connectivity.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
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

  late PageController pageController;
  RxInt currentPage = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    pageController = PageController(initialPage: 0, keepPage: true);
  }

  void onChangeTab(int value) {
    try {
      currentPage.value = value;
      pageController.jumpToPage(value);
    } catch (e) {
      print(e);
      Phoenix.rebirth(Get.context!);
    }
  }

  Future<void> initActivity() async {
    connectivityResult = await (Connectivity().checkConnectivity());
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (user.value.username == null) {
      } else if (user.value.username != null && user.value.kanji != "") {
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
    await FkUserAgent.init();
    userAgent = FkUserAgent.webViewUserAgent;
    print(userAgent);
  }
}

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/api/privacy_api.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/home_page/home_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/login_page/login_page_controller.dart';
import 'package:medical_chain_mobile_ui/models/User.dart';
import 'package:medical_chain_mobile_ui/screens/login_page/login_welcome_page.dart';

class PrivacyController extends GetxController {
  RxBool privacy = true.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    checkPrivacy();
    super.onInit();
  }

  Future<void> checkPrivacy() async {
    var res = await getPrivacy();
    if (res.length == 0) {
      privacy.value = false;
    } else
      privacy.value = true;
    print("aaaaaa->>$res");
  }

  Future<void> upPrivacy(bool status) async {
    privacy.value = status;
    var res = await updatePrivacy(status: status);
    print(res);
    // if (res == true)
    //   privacy.value = status;
    // else
    //   privacy.value = !status;
  }

  logout() async {
    String? token = await FirebaseMessaging.instance.getToken();
    print(token.toString());
    var unSubcribe = await Get.put(LoginPageController())
        .unSubcribe(token: token.toString());
    print(unSubcribe);
    Get.put(GlobalController()).db.deleteFromDisk();
    Get.put(GlobalController()).onChangeTab(0);
    Get.offAll(() => LoginWelcomePage());
  }

  logout2() {
    if (Get.put(GlobalController()).user.value.id != null &&
        Get.put(GlobalController()).user.value.kanji != "") {
      Get.put(GlobalController()).user.value = User();
      Get.put(GlobalController()).db.deleteFromDisk();
      Get.put(HomePageController()).onClose();
      Get.offAll(() => LoginWelcomePage());
    }
  }
}

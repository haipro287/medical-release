import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/api/privacy_api.dart';

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
    privacy.value = res;
  }

  Future<void> upPrivacy(bool status) async {
    var res = await updatePrivacy(status: status);
    print(res);
    if (res == "ok") privacy.value = status;
  }
}

import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/models/User.dart';

class GlobalController extends GetxController {
  var db;
  Rx<User> user = User().obs;
  var sharingStatus = "SENT_DATA".obs;
  var historyStatus = "SENDING_MODE".obs;
  var recordsTabMode = 0.obs;
  var editToShareMode = "".obs;
}

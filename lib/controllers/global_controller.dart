import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/models/User.dart';

class GlobalController extends GetxController {
  var db;
  Rx<User> user = User().obs;
  var sharingStatus = "SENT_DATA".obs;
}

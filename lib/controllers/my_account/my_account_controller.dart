import 'package:get/get.dart';

class MyAccountController extends GetxController {
  var avatar = 0xFFD0E8FF.obs;
  String userName = "hang1234";
  RxString fullName = "佐藤桜".obs;
  RxString alphabetName = "Sato Sakura".obs;
  RxString dob = "1960年4月1日".obs;
  RxString email = "hang@gmail.com".obs;
  RxString phoneNumber = "09876543".obs;
  RxString citizenCode = "1234567".obs;

  bool emailVerified = true;
  bool phoneVerified = true;
}
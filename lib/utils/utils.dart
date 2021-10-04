import 'dart:convert';

import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/api/signature_service.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';

String getMessage() {
  String messageSign = "this is request of mobile app";
  String signature = SignatureService.getSignature(messageSign,
      Get.put(GlobalController()).user.value.privateKey.toString());

  var jsonMessage = jsonEncode({
    "message": messageSign,
    "signature": signature,
  });
  var bytes = utf8.encode(jsonMessage);
  var message = base64Url.encode(bytes);

  return message;
}

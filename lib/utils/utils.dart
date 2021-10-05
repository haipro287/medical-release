import 'dart:convert';

import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/api/signature_service.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';

String getMessage(String serviceId) {
  String messageSign =
      "{\"Creator\": \"\",\"ServiceId\": \"$serviceId\",\"UserId\": \"${Get.put(GlobalController()).user.value.blockchainUserId}\",\"ServiceUserId\": \"\",\"IsActive\": true}";
  String signature = SignatureService.getSignature(
      jsonDecode(messageSign).toString(),
      Get.put(GlobalController()).user.value.privateKey.toString());

  var jsonMessage = jsonEncode({
    "message": messageSign,
    "signature": signature,
    "pubKey": Get.put(GlobalController()).user.value.publicKey
  });
  var bytes = utf8.encode(jsonMessage);
  var message = base64Url.encode(bytes);
  message = message.replaceAll("=", "");

  return message;
}

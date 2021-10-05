import 'dart:convert';

import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/api/signature_service.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';

String getMessage(String serviceId) {
  String messageSign = jsonEncode({
    "creator": "",
    "serviceId": "$serviceId",
    "userId": "${Get.put(GlobalController()).user.value.blockchainUserId}",
    "serviceUserId": "",
    "isActive": true
  });
  var a = utf8.encode(messageSign.toString());
  var b = base64Url.encode(a);
  var c = b.replaceAll("=", "");

  String signature = SignatureService.getSignature(
      c, Get.put(GlobalController()).user.value.privateKey.toString());

  var jsonMessage = jsonEncode({
    "message": c,
    "signature": signature,
    "pubKey": Get.put(GlobalController()).user.value.publicKey
  });
  var bytes = utf8.encode(jsonMessage);
  var message = base64Url.encode(bytes);
  message = message.replaceAll("=", "");

  return message;
}

String getMessage1(String ownerId) {
  String messageSign = jsonEncode({
    "ownerId": ownerId,
    "viewerId": Get.put(GlobalController()).user.value.blockchainUserId,
  });
  var a = utf8.encode(messageSign.toString());
  var b = base64Url.encode(a);
  var c = b.replaceAll("=", "");

  String signature = SignatureService.getSignature(
      c, Get.put(GlobalController()).user.value.privateKey.toString());

  var jsonMessage = jsonEncode({
    "message": c,
    "signature": signature,
    "pubKey": Get.put(GlobalController()).user.value.publicKey
  });
  var bytes = utf8.encode(jsonMessage);
  var message = base64Url.encode(bytes);
  message = message.replaceAll("=", "");

  return message;
}

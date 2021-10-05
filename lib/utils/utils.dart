import 'dart:convert';

import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/api/signature_service.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';

String getMessage(String serviceId) {
  String messageSign =
      "{\"Creator\": \"\",\"ServiceId\": \"$serviceId\",\"UserId\": \"${Get.put(GlobalController()).user.value.blockchainUserId}\",\"ServiceUserId\": \"\",\"IsActive\": }";
  String signature = SignatureService.getSignature(messageSign,
      Get.put(GlobalController()).user.value.privateKey.toString());

  var jsonMessage = jsonEncode({
    "message": messageSign,
    "signature": signature,
  });
  var bytes = utf8.encode(jsonMessage);
  var message = base64Url.encode(bytes);
  message = message.replaceAll("=", "");

  return "eyJtZXNzYWdlIjogIntcIkNyZWF0b3JcIjogXCJhc2Fkc2RhXCIsXCJTZXJ2aWNlSWRcIjogXCJzdHJpbmdcIixcIlVzZXJJZFwiOiBcInN0cmluZ1wiLFwiU2VydmljZVVzZXJJZFwiOiBcInN0cmluZ1wiLFwiSXNBY3RpdmVcIjogdHJ1ZX0iLCJzaWduYXR1cmUiOiAic3VpZGhmc2hqa2ZoaiIsInB1YktleSI6ICJkZnNkZiJ9";
}

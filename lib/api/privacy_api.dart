import 'dart:convert';

import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';

Future getPrivacy() async {
  try {
    GlobalController globalController = Get.put(GlobalController());
    var response;
    var userID = globalController.user.value.id.toString();
    CustomDio customDio = CustomDio();
    customDio.dio.options.headers["Authorization"] =
        globalController.user.value.certificate.toString();

    response = await customDio.get(
      "/users/$userID/privacy",
    );

    var json = jsonDecode(response.toString());
    print(json.toString());
    return (json["data"]);
  } catch (e, s) {
    print(e);
    print(s);
    return null;
  }
}

Future updatePrivacy({required bool status}) async {
  try {
    GlobalController globalController = Get.put(GlobalController());
    var response;
    var userID = globalController.user.value.id.toString();
    CustomDio customDio = CustomDio();
    customDio.dio.options.headers["Authorization"] =
        globalController.user.value.certificate.toString();

    response = await customDio.put("/users/$userID/privacy", {
      "data": {"status": status}
    });

    var json = jsonDecode(response.toString());
    print(json.toString());
    return (json["success"]);
  } catch (e, s) {
    print(e);
    print(s);
    return null;
  }
}

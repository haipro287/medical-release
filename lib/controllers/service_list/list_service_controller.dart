import 'dart:convert';

import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';

class ListServiceController extends GetxController {
  GlobalController globalController = Get.put(GlobalController());
  List serviceList = [
    {
      'appName': 'Facebook',
      'userName': 'fdsvfd123',
      'isConnected': true.obs,
    },
    {
      'appName': 'Twitter',
      'userName': 'twitteruser123',
      'isConnected': true.obs,
    },
    // {
    //   'appName': 'Facebook',
    //   'userName': 'fdsvfd123',
    //   'isConnected': true.obs,
    // },
    // {
    //   'appName': 'Twitter',
    //   'userName': 'twitteruser123',
    //   'isConnected': false.obs,
    // },
    // {
    //   'appName': 'Facebook',
    //   'userName': 'fdsvfd123',
    //   'isConnected': true.obs,
    // },
    // {
    //   'appName': 'Twitter',
    //   'userName': 'twitteruser123',
    //   'isConnected': false.obs,
    // },
    // {
    //   'appName': 'Facebook',
    //   'userName': 'fdsvfd123',
    //   'isConnected': true.obs,
    // },
    // {
    //   'appName': 'Twitter',
    //   'userName': 'twitteruser123',
    //   'isConnected': false.obs,
    // },
    // {
    //   'appName': 'Facebook',
    //   'userName': 'fdsvfd123',
    //   'isConnected': true.obs,
    // },
    // {
    //   'appName': 'Twitter',
    //   'userName': 'twitteruser123',
    //   'isConnected': false.obs,
    // },
  ];


  Future disconnectService({required String serviceId}) async {
    try {
      var response;
      var userID = globalController.user.value.id.toString();
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();

      response = await customDio
          .post("/user/$userID/service/disconnect/$serviceId", {});

      var json = jsonDecode(response.toString());
      print(json.toString());
      return (json["success"]);
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }
}

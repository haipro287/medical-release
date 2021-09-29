import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';
import 'package:medical_chain_mobile_ui/models/service.dart';

class ListServiceController extends GetxController {
  GlobalController globalController = Get.put(GlobalController());
  RxList<Service> serviceList = <Service>[].obs;
  TextEditingController searchService = TextEditingController();
  int offset = 0;
  int totalPage = 0;

  Future disconnectService({required String serviceId}) async {
    try {
      var response;
      var userID = globalController.user.value.id.toString();
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();

      response = await customDio.post(
        "/user/$userID/service/disconnect/$serviceId",
        {},
      );

      var json = jsonDecode(response.toString());
      print(json.toString());
      return (json["success"]);
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  Future connectService({required String serviceId}) async {
    try {
      var response;
      var userID = globalController.user.value.id.toString();
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();

      response = await customDio.post(
        "/user/$userID/service/connect/$serviceId",
        {},
      );

      var json = jsonDecode(response.toString());
      print(json.toString());
      return (json["success"]);
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  Future<List<Service>> getServiceList() async {
    try {
      offset = 0;
      totalPage = 0;
      var userID = globalController.user.value.id.toString();
      var response;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();
      response = await customDio.get(
          "/user/$userID/services?name=${searchService.text}&limit=10&offset=$offset");
      var json = jsonDecode(response.toString());
      print(json["data"]);
      var list = json["data"]["results"] ?? json["data"] ?? [];
      List<Service> listService = [];
      totalPage = json["data"]["total"] ?? 0;
      for (var i = 0; i < list.length; i++) {
        print(list[i]);
        Service service = new Service();
        service.id = list[i]['id'];
        service.name = list[i]['name'];
        service.url = list[i]['url'];
        service.username = list[i]['username'];
        service.isConnected = list[i]["connected"] ?? false;
        service.icon = list[i]['icon'];
        service.description = list[i]["description"] ?? null;
        service.redirectURL = list[i]["callbackUrl"] ?? null;
        listService.add(service);
      }
      serviceList.clear();
      serviceList.value = listService;
      offset = serviceList.length;

      return (listService);
    } catch (e, s) {
      print(e);
      print(s);
      return [];
    }
  }

  Future<List<Service>> getMoreServiceList() async {
    try {
      var userID = globalController.user.value.id.toString();
      var response;
      CustomDio customDio = CustomDio();
      customDio.dio.options.headers["Authorization"] =
          globalController.user.value.certificate.toString();
      response = await customDio.get(
          "/user/$userID/services?name=${searchService.text}&limit=10&offset=$offset");
      var json = jsonDecode(response.toString());
      print(json["data"]);
      var list = json["data"]["results"] ?? json["data"] ?? [];
      List<Service> listService = [];

      for (var i = 0; i < list.length; i++) {
        print(list[i]);
        Service service = new Service();
        service.id = list[i]['id'];
        service.name = list[i]['name'];
        service.url = list[i]['url'];
        service.username = list[i]['username'];
        service.isConnected = list[i]["connected"] ?? false;
        service.icon = list[i]['icon'];
        service.description = list[i]["description"] ?? null;
        service.redirectURL = list[i]["callbackUrl"] ?? null;
        listService.add(service);
      }

      serviceList.addAll(listService);
      offset = serviceList.length;

      return (listService);
    } catch (e, s) {
      print(e);
      print(s);
      return [];
    }
  }
}

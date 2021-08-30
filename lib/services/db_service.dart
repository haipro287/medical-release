import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/models/User.dart';

Future<void> initDB() async {
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  var db = await Hive.openBox('medical-chain');
  GlobalController globalController = Get.put(GlobalController());
  globalController.db = db;
}

Future<void> initDBLogin() async {
  await Hive.initFlutter();
  var db = await Hive.openBox('medical-chain');
  GlobalController globalController = Get.put(GlobalController());
  globalController.db = db;
}

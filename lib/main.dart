import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/i18n.dart';
import 'package:medical_chain_mobile_ui/models/User.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_screen.dart';
import 'package:medical_chain_mobile_ui/screens/login_page/login_page_screen.dart';
import 'package:medical_chain_mobile_ui/screens/login_page/login_welcome_page.dart';
import 'package:medical_chain_mobile_ui/screens/scanQR/scan_QR_screen.dart';

Future<void> main() async {
  await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  var db = await Hive.openBox('medical-chain');

  GlobalController globalController = Get.put(GlobalController());
  globalController.db = db;
  if (globalController.db.get("user") != null)
    globalController.user.value = globalController.db.get("user");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  GlobalController globalController = Get.put(GlobalController());

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return GetMaterialApp(
      title: 'Flutter Demo',
      translations: Messages(),
      locale: Locale('ja', 'JP'),
      fallbackLocale: Locale('en', 'UK'),
      defaultTransition:
          Platform.isIOS ? Transition.cupertino : Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "SFPro"),
      home: globalController.user.value.username != null
          ? HomePageScreen()
          : LoginWelcomePage(),
    );
  }
}

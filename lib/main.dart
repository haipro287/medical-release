import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:medical_chain_mobile_ui/controllers/globle_controller.dart';
import 'package:medical_chain_mobile_ui/i18n.dart';
import 'package:medical_chain_mobile_ui/models/User.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_screen.dart';
import 'package:medical_chain_mobile_ui/screens/login_page/login_page_screen.dart';
import 'package:medical_chain_mobile_ui/services/certificate_service.dart';

Future<void> main() async {
  // await dotenv.load(fileName: ".env");
  await Hive.initFlutter();
  Hive.registerAdapter(UserAdapter());
  var db = await Hive.openBox('medical-chain');

  GlobleController globleController = Get.put(GlobleController());
  globleController.db = db;
  if (globleController.db.get("user") != null)
    globleController.user.value = globleController.db.get("user");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  GlobleController globleController = Get.put(GlobleController());

  @override
  Widget build(BuildContext context) {
    print(CertificateApiService.getCertificate());
    return GetMaterialApp(
      title: 'Flutter Demo',
      translations: Messages(),
      locale: Locale('ja', 'JP'),
      fallbackLocale: Locale('en', 'UK'),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: globleController.user.value.username != null
          ? HomePageScreen()
          : LoginPageScreen(),
    );
  }
}

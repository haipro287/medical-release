import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/signup_page/signup_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/update_application/update_application_controller.dart';
import 'package:medical_chain_mobile_ui/i18n.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_screen.dart';
import 'package:medical_chain_mobile_ui/screens/internet/no_internet_screeen.dart';
import 'package:medical_chain_mobile_ui/screens/login_page/login_welcome_page.dart';
import 'package:medical_chain_mobile_ui/services/db_service.dart';
import 'package:medical_chain_mobile_ui/services/local_notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService.init();
  await Firebase.initializeApp();
  await dotenv.load(fileName: ".env");

  await initDB();

  UpdateAppController updateAppController = Get.put(UpdateAppController());
  GlobalController globalController = Get.put(GlobalController());
  SignupPageController signupPageController = Get.put(SignupPageController());
  await globalController.initActivity();
  await globalController.getInfoDevice();
  if (globalController.db.get("user") != null)
    globalController.user.value = globalController.db.get("user");
  // if (globalController.user.value.id != null)
  //   var info = await Get.put(MyAccountController()).getUserInfo();
  runApp(
    Phoenix(
      child: MyApp(),
    ),
  );
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
      localizationsDelegates: [GlobalMaterialLocalizations.delegate],
      supportedLocales: [
        const Locale('ja'),
        const Locale('en'),
      ],
      translations: Messages(),
      locale: Locale('ja', 'JP'),
      fallbackLocale: Locale('en', 'UK'),
      defaultTransition:
          Platform.isIOS ? Transition.cupertino : Transition.rightToLeft,
      transitionDuration: Duration(milliseconds: 500),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: "SFPro"),
      home: home(),
    );
  }

  Widget home() {
    if (globalController.user.value.kanji == "") {
      return LoginWelcomePage();
    } else if (globalController.user.value.username == null)
      return LoginWelcomePage();
    else if (globalController.user.value.username != null) {
      if (globalController.connectivityResult == ConnectivityResult.none) {
        return NoInternetScreen();
      } else
        return HomePageScreen();
    } else
      return LoginWelcomePage();
  }
}

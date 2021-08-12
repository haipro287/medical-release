import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/api/certificate_service.dart';
import 'package:medical_chain_mobile_ui/api/signature_service.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';
import 'package:medical_chain_mobile_ui/models/status.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';
import 'package:medical_chain_mobile_ui/services/response_validator.dart';

class LoginPageController extends GetxController {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  var isHidePassword = true.obs;
  var isHideConfirmPassword = true.obs;

  var messValidateUsername = "".obs;
  var messValidatePassword = "".obs;

  @override
  void onInit() {
    password.addListener(() {
      messValidatePassword.value = "";
    });
    username.addListener(() {
      messValidateUsername.value = "";
    });
    super.onInit();
  }

  void changeHidePassword() {
    isHidePassword.value = !isHidePassword.value;
  }

  Future getPing(String certificate) async {
    try {
      Response response;
      CustomDio customDio = new CustomDio();
      print({"certificate": certificate});
      customDio.dio.options.headers["Authorization"] = certificate;
      response = await customDio.post(
        "/auth/ping",
        certificate,
      );
      return response;
    } catch (e) {
      return null;
    }
  }

  Future getCredential(String username) async {
    try {
      var response;
      CustomDio customDio = CustomDio();
      response = await customDio.post("/auth/credential", {
        "username": username,
        "_actionType": "POST_API-AUTH-PING",
      });
      return response;
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  Future signup(String username, String password) async {
    try {
      Map<String, dynamic> keyPair = generateKeyPairAndEncrypt(password);
      Response response;
      CustomDio customDio = CustomDio();
      response = await customDio.post("/user", {
        "publicKey": keyPair["publicKey"],
        "encryptedPrivateKey": keyPair["encryptedPrivateKey"],
        "displayName": username,
        "username": username,
      });
      return response;
    } catch (e, s) {
      print(e);
      print(s);
      return null;
    }
  }

  Future<void> login() async {
    if (username.text == "") {
      messValidateUsername.value = "Username can not be empty";
    } else if (password.text == "") {
      messValidatePassword.value = "Password can not be empty";
    } else {
      var responseCredential = await getCredential(username.text);
      Status validateUsername = ResponseValidator.check(responseCredential);
      if (validateUsername.status == "OK") {
        print({"data": responseCredential});
        var data = responseCredential.data["data"];
        var userId = data["_id"];
        var publicKey = data['publicKey'];
        var encryptedPrivateKey = data['encryptedPrivateKey'];
        String? privateKey =
            decryptAESCryptoJS(encryptedPrivateKey, password.text);
        Status validatePassword = new Status();

        if (privateKey == null)
          validatePassword =
              new Status(status: "ERROR", message: "WRONG.PASSWORD");
        else
          validatePassword = new Status(status: "SUCCESS", message: "SUCCESS");

        if (validatePassword.status == "SUCCESS") {
          var certificateInfo = SignatureService.getCertificateInfo(userId);

          String signature = SignatureService.getSignature(
              certificateInfo, privateKey as String);
          String times = TimeService.getTimeNow().toString();
          String certificate = SignatureService.getCertificateLogin(
              certificateInfo, signature, publicKey, times);

          var responsePing = await getPing(certificate);
          Status validateServer2 = ResponseValidator.check(responsePing);
          print({'pingData': validateServer2.status});
          if (validateServer2.status == "OK") {
            var dataPing = responsePing.data['data'];
            var user = dataPing;
            print({'email': user.id});
          } else {
            messValidatePassword.value = "Wrong password";
          }
        }
      } else {
        messValidateUsername.value = "Username Invalid";
      }
    }
  }
}

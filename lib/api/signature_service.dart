import 'dart:convert';

import 'package:medical_chain_mobile_ui/api/certificate_service.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';

class SignatureService {
  static getCertificateInfo(
    String? userId,
  ) {
    print(TimeService.timeToBackEndMaster(TimeService.getTimeNow()));
    var certificateInfo = jsonEncode({
      "id": userId,
      "timestamp": TimeService.timeToBackEndMaster(TimeService.getTimeNow()),
      "exp": 2799360000000
    });
    return certificateInfo;
  }

  static String getSignature(var certificateInfo, String privateKey) {
    var hashCertificateInfo = hashMessage(certificateInfo);
    var signature = signMessage(privateKey, hashCertificateInfo);
    return signature;
  }

  static String getCertificate(
      var certificateInfo, String signature, String publicKey) {
    var certificate = jsonEncode({
      "signature": signature,
      "certificateInfo": jsonDecode(certificateInfo),
      "publicKey": publicKey,
    });
    return certificate;
  }

  static List<String> getCertificateLogin(
      var certificateInfo,
      String? userId,
      String? email,
      String? username,
      String? encryptedPrivateKey,
      String signature,
      String publicKey,
      String time) {
    print({"cf": certificateInfo});
    var certificate = jsonEncode({
      "signature": signature,
      "certificateInfo": jsonDecode(certificateInfo),
      "publicKey": publicKey,
    });

    var body = jsonEncode({
      "data": {
        "email": email,
        "username": username,
        "encryptedPrivateKey": encryptedPrivateKey,
        "publicKey": publicKey,
        "_actionType": "POST_V1-USER-BWIT-QVZVCZHYJ4FPCPPT-CONTACTS",
        "_timestamp": time,
      },
      "_signature": signature,
    });

    print(body);
    print(certificate);

    List<String> result = [];
    result.add(certificate);
    result.add(body);
    print({"authorization": certificate.toString()});
    return result;
  }

  static getCertificateFinal(var certificateInfo, String signature,
      String _signature, String publicKey, String time) {
    var certificateFinal = jsonEncode({
      "signature": signature,
      "certificateInfo": jsonDecode(certificateInfo),
      "publicKey": publicKey,
      "_signature": _signature,
      "_actionType": "POST_API-AUTH-PING",
      "_timestamp": time
    });
    return certificateFinal;
  }
}

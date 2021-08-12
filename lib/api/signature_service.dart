import 'dart:convert';

import 'package:medical_chain_mobile_ui/api/certificate_service.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';

class SignatureService {
  static getCertificateInfo(String userId) {
    var certificateInfo = jsonEncode({
      "id": userId,
      "timestamp": TimeService.getTimeNow().toString(),
      "exp": 3600000 * 24 * 30
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

  static String getCertificateLogin(
      var certificateInfo, String signature, String publicKey, String time) {
    var certificate = jsonEncode({
      "signature": signature,
      "certificateInfo": jsonDecode(certificateInfo),
      "publicKey": publicKey,
      // "_actionType": "POST_API-AUTH-PING",
      // "_timestamp": time
    });
    return certificate;
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

import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/api/signature_service.dart';
import 'package:medical_chain_mobile_ui/controllers/globle_controller.dart';

class CertificateApiService {
  static String getCertificate() {
    var certificateInfo = SignatureService.getCertificateInfo(
        Get.put(GlobleController()).user.value.username.toString());

    String signature = SignatureService.getSignature(certificateInfo,
        Get.put(GlobleController()).user.value.privateKey.toString());

    String certificate = SignatureService.getCertificate(certificateInfo,
        signature, Get.put(GlobleController()).user.value.publicKey.toString());
    return certificate;
  }

  static String getCertificateNewPassword(
      String userName, String publicKey, String privateKey) {
    var certificateInfo = SignatureService.getCertificateInfo(userName);

    String signature =
        SignatureService.getSignature(certificateInfo, privateKey);

    String certificate =
        SignatureService.getCertificate(certificateInfo, signature, publicKey);
    return certificate;
  }
}

import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/api/signature_service.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';

class CertificateApiService {
  static String getCertificate() {
    var certificateInfo = SignatureService.getCertificateInfo(
        Get.put(GlobalController()).user.value.id.toString());

    String signature = SignatureService.getSignature(certificateInfo,
        Get.put(GlobalController()).user.value.privateKey.toString());

    String certificate = SignatureService.getCertificate(certificateInfo,
        signature, Get.put(GlobalController()).user.value.publicKey.toString());
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

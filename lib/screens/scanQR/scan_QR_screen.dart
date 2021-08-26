import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/scanQRController/scanQR_controller.dart';
import 'package:medical_chain_mobile_ui/screens/scanQR/test_qr.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:qr_flutter/qr_flutter.dart';

class ScanQRScreen extends StatelessWidget {
  QrScanController qrScanController = Get.put(QrScanController());
  String? type;

  ScanQRScreen({this.type});

  @override
  Widget build(BuildContext context) {
    if (type.toString() != "scan") {
      qrScanController.init(1);
    } else
      qrScanController.init(0);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          PageView(
            controller: qrScanController.pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              Stack(
                children: [
                  QRView(
                    key: GlobalKey(debugLabel: 'QR'),
                    onQRViewCreated: _onQRViewCreated,
                    overlay: QrScannerOverlayShape(
                        borderColor: Colors.white,
                        borderLength: 30,
                        borderWidth: 10,
                        cutOutSize: getWidth(237),
                        cutOutBottomOffset: 120),
                  ),
                  Container(
                    width: double.infinity,
                    child: Column(
                      children: [
                        Spacer(),
                        Text(
                          "scan_qr_guide".tr,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(
                          height: getHeight(20),
                        ),
                        Obx(() {
                          return AnimatedSwitcher(
                            duration: Duration(seconds: 1),
                            child: qrScanController.isFlash.value
                                ? Bouncing(
                                    onPress: () {
                                      qrScanController.controller
                                          ?.toggleFlash();
                                      qrScanController.isFlash.value = false;
                                    },
                                    child: SvgPicture.asset(
                                        "assets/images/flashOn.svg"),
                                  )
                                : Bouncing(
                                    onPress: () {
                                      qrScanController.controller
                                          ?.toggleFlash();
                                      qrScanController.isFlash.value = true;
                                    },
                                    child: SvgPicture.asset(
                                        "assets/images/flashOff.svg"),
                                  ),
                          );
                        }),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.3,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset(
                        "assets/images/my_qr_background.png",
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: EdgeInsets.all(getWidth(30)),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  getWidth(12),
                                ),
                                color: Colors.white),
                            child: QrImage(
                              dataModuleStyle: const QrDataModuleStyle(
                                dataModuleShape: QrDataModuleShape.circle,
                                color: Colors.black,
                              ),
                              embeddedImage:
                                  AssetImage("assets/images/avatar.png"),
                              embeddedImageStyle: QrEmbeddedImageStyle(
                                size: Size(
                                  getWidth(30),
                                  getWidth(30),
                                ),
                              ),
                              data: Get.put(GlobalController())
                                  .user
                                  .value
                                  .username
                                  .toString(),
                              version: QrVersions.auto,
                              size: getWidth(180),
                              gapless: false,
                            ),
                          ),
                          SizedBox(
                            height: getHeight(27),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: getWidth(27)),
                            child: Text(
                              "my_qr_guide".tr,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: getWidth(17), color: Colors.white),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
          SafeArea(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: EdgeInsets.symmetric(
                        horizontal: getWidth(16), vertical: getHeight(40)),
                    child: Obx(() {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Bouncing(
                            onPress: () {
                              qrScanController.changeTab(0);
                            },
                            child: Container(
                              width: getWidth(170),
                              padding: EdgeInsets.symmetric(
                                horizontal: getWidth(11),
                                vertical: getHeight(8),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    getWidth(20),
                                  ),
                                  border: qrScanController.index.value == 0
                                      ? Border.all(
                                          width: 2, color: Colors.white)
                                      : null,
                                  color: qrScanController.index.value == 0
                                      ? Colors.white.withOpacity(0.2)
                                      : null),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  Text(
                                    "scan_qr".tr.substring(0, 5),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getWidth(17),
                                    ),
                                  ),
                                  Text(
                                    "scan_qr".tr.substring(5),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getWidth(17),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Bouncing(
                            onPress: () {
                              qrScanController.changeTab(1);
                            },
                            child: Container(
                              width: getWidth(170),
                              padding: EdgeInsets.symmetric(
                                horizontal: getWidth(8),
                                vertical: getHeight(8),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                    getWidth(20),
                                  ),
                                  border: qrScanController.index.value == 1
                                      ? Border.all(
                                          width: 2, color: Colors.white)
                                      : null,
                                  color: qrScanController.index.value == 1
                                      ? Colors.white.withOpacity(0.2)
                                      : null),
                              child: Wrap(
                                alignment: WrapAlignment.center,
                                children: [
                                  Text(
                                    "my_qr".tr.substring(0,2),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getWidth(17),
                                    ),
                                  ),
                                  Text(
                                    "my_qr".tr.substring(2),
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: getWidth(17),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    margin: EdgeInsets.only(
                        right: getWidth(30), top: getHeight(20)),
                    child: Bouncing(
                      onPress: () {
                        Get.back();
                      },
                      child: SvgPicture.asset("assets/images/cancel.svg"),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.qrScanController.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      controller.pauseCamera();
      print(scanData.code);
      Get.to(() => TestQRScreen(qr: scanData.code));
      controller.resumeCamera();
    });
  }
}

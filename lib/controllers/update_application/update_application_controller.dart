import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateAppController extends GetxController {
  String? version;
  Future<dynamic> getVersion() async {
    Dio dio = Dio();
    var response = await dio.get(dotenv.env['UPDATE_VERSION_API']! + "tags");
    print(response);
    return response.data[0]["name"];
  }

  void launchURL(_url) async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    version = await getVersion();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    if (packageInfo.version != version.toString()) {
      showDialog(
          context: Get.context!,
          barrierColor: Colors.black38,
          builder: (builder) {
            return Container(
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      getWidth(5),
                    ),
                  ),
                  child: Material(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                    child: Padding(
                      padding: EdgeInsets.all(getWidth(10)),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Có version mới rồi tải lại đê".toUpperCase(),
                              style: TextStyle(fontSize: 20)),
                          TextButton(
                            onPressed: () async {
                              launchURL(dotenv.env['UPDATE_VERSION_URL']! +
                                  "/releases/download/$version/app.apk");
                            },
                            child: Text(
                              "Bấm để tải",
                              style: TextStyle(fontSize: 16),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          });
    }
    super.onInit();
  }
}

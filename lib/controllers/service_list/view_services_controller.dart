import 'dart:io';

import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ViewServicesController extends GetxController {
  String title = "";
  String url = "";
  int percent = 0;
  late String urlNotSplit;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  void setTitle(String _title) {
    title = _title;
    update(["head"]);
  }

  void setUrl(String _url) {
    url = _url;
    update(["head"]);
  }

  void setLoading(int _percent) {
    percent = _percent;
    update(["loading"]);
  }

  void serUrlNotSplit(String urlN) {
    urlNotSplit = urlN;
  }
}

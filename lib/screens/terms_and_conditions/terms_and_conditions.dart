import 'package:flutter/material.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:get/get.dart';

class TermsAndConditionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
        context,
        'terms_of_use'.tr,
      ),
      backgroundColor: Colors.white,
      body: WebView(
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl:
              "https://www.apple.com/legal/internet-services/terms/site.html"),
    );
  }
}

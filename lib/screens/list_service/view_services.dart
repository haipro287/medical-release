import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/view_services_controller.dart';
import 'package:metadata_fetch/metadata_fetch.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatelessWidget {
  String url;
  dynamic callbackURL;
  dynamic isConnected;
  WebViewPage(
      {required this.url,
      required this.callbackURL,
      required this.isConnected});
  @override
  Widget build(BuildContext context) {
    ViewServicesController viewServicesController =
        Get.put(ViewServicesController());
    print(url);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(
            Icons.clear,
            color: Colors.black,
            size: 32,
          ),
          onPressed: () {
            Get.back();
          },
        ),
        title: GestureDetector(
          onTap: () {
            Clipboard.setData(
              ClipboardData(text: viewServicesController.urlNotSplit),
            );
          },
          child: Container(
            height: 45,
            width: 400,
            decoration: BoxDecoration(
                color: Color.fromRGBO(240, 242, 245, 1),
                borderRadius: BorderRadius.circular(5)),
            // margin:
            //     EdgeInsets.only(right: MediaQuery.of(context).size.width * 0.1),
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GetBuilder<ViewServicesController>(
              id: "head",
              builder: (controller) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      viewServicesController.title,
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      viewServicesController.url,
                      style: TextStyle(
                        color: Color.fromRGBO(115, 117, 121, 1),
                        fontSize: 14,
                      ),
                    )
                  ],
                );
              },
            ),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              // UrlService.openLink(webViewEntityController.urlNotSplit);
            },
            child: Container(
              padding: EdgeInsets.only(right: 15),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 32,
              ),
            ),
          )
        ],
        bottom: PreferredSize(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<ViewServicesController>(
                  id: "loading",
                  builder: (controller) {
                    return Container(
                      height: 2,
                      width:
                          (controller.percent == 0 || controller.percent == 100)
                              ? 0
                              : MediaQuery.of(context).size.width /
                                  100 *
                                  controller.percent,
                      color: Colors.blue,
                    );
                  }),
              Container(
                color: Colors.grey.shade300,
                height: 1.0,
              ),
            ],
          ),
          preferredSize: Size.fromHeight(1.0),
        ),
      ),
      backgroundColor: Colors.white,
      body: WebView(
        onPageStarted: (e) async {
          viewServicesController.serUrlNotSplit(e);
          var data = await MetadataFetch.extract(e);
          viewServicesController.setTitle(data!.title.toString());
          var b = url.split("/");
          viewServicesController.setUrl(b[2].replaceAll(RegExp('www.'), ""));
        },
        onProgress: (percent) {
          viewServicesController.setLoading(percent);
        },
        onPageFinished: (e) {
          if (e.toString() == callbackURL.toString()) {
            isConnected = true;
            Get.back();
          }
        },
        javascriptMode: JavascriptMode.unrestricted,
        initialUrl: url,
      ),
    );
  }
}

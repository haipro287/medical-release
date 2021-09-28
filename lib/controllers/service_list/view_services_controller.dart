import 'package:get/get.dart';

class ViewServicesController extends GetxController {
  String title = "";
  String url = "";
  int percent = 0;
  late String urlNotSplit;

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

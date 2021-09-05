import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_screen.dart';
import 'package:medical_chain_mobile_ui/screens/sharing_history_page/sharing_history_details_component.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';
import 'package:medical_chain_mobile_ui/widgets/search_navigator.dart';
import 'package:medical_chain_mobile_ui/widgets/text_box.dart';

class ShareHistoryPage extends StatelessWidget {
  GlobalController globalController = Get.put(GlobalController());
  ShareHistoryController sharingHistoryController =
      Get.put(ShareHistoryController());
  @override
  Widget build(BuildContext context) {
    var mode = globalController.historyStatus.value;
    return WillPopScope(
      onWillPop: () async {
        Get.to(() => HomePageScreen());
        return true;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appBar(
          context,
          mode == "SENDING_MODE" ? 'viewDataShare'.tr : "viewDataRequest".tr,
          null,
          true,
        ),
        backgroundColor: Colors.white,
        body: Column(children: [
          inputSearch(
            context,
            hintText: "sharing_history_page".tr,
            textEditingController: sharingHistoryController.searchInput,
            onSearch: sharingHistoryController.search,
          ),
          sharingHistoryNavigator(controller: sharingHistoryController),
          Obx(
            () => sharingHistoryController.isHideNotiSearch.value
                ? Container(
                    color: Color(0xFFF6F7FB),
                    height: getHeight(20),
                  )
                : customBoxHeader(
                    sharingHistoryController.searchInput.text +
                        " " +
                        "so".tr +
                        " " +
                        sharingHistoryController.searchList.length.toString() +
                        "records_result".tr,
                  ),
          ),
          Expanded(
            child: Container(
              color: Color(0xFFF6F7FB),
              child: PageView(
                controller: sharingHistoryController.pageController,
                physics: NeverScrollableScrollPhysics(),
                children: List.generate(5, (index) {
                  return Container(
                    alignment: Alignment.center,
                    child: Obx(
                      () => ListView(
                        children: sharingHistoryController.searchList
                            .map((e) => historyDetailComponent(record: e))
                            .toList(),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/screens/sharing_history_page/sharing_history_details_component.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';
import 'package:medical_chain_mobile_ui/widgets/search_navigator.dart';

class ShareHistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ShareHistoryController sharingHistoryController =
        Get.put(ShareHistoryController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context, '共有設定'.tr),
      backgroundColor: Colors.white,
      body: Column(children: [
        inputSearch(
          context,
          hintText: "ユーザーID、氏名、ニックネームで検索",
          textEditingController: sharingHistoryController.searchInput,
          onSearch: sharingHistoryController.search,
        ),
        sharingHistoryNavigator(controller: sharingHistoryController),
        Expanded(
          child: Container(
            color: Color(0xFFF6F7FB),
            child: PageView(
              controller: sharingHistoryController.pageController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Container(
                  alignment: Alignment.center,
                  child: ListView(
                    children: List.generate(4, (index) {
                      return historyDetailComponent(status: 'sharing');
                    }),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: ListView(
                    children: List.generate(2, (index) {
                      return historyDetailComponent(status: 'sharing');
                    }),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: ListView(
                    children: List.generate(2, (index) {
                      return historyDetailComponent(status: 'expired');
                    }),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: ListView(
                    children: List.generate(2, (index) {
                      return historyDetailComponent(status: 'pending');
                    }),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: ListView(
                    children: List.generate(2, (index) {
                      return historyDetailComponent(status: 'rejected');
                    }),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

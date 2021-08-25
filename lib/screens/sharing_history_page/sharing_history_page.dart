import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
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
                  child: Column(
                    children: List.generate(2, (index) {
                      return Container(
                        margin: EdgeInsets.only(
                          top: getHeight(20),
                        ),
                        child: SvgPicture.asset('assets/images/template.svg'),
                      );
                    }),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Sharing"),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Expired"),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Pending"),
                ),
                Container(
                  alignment: Alignment.center,
                  child: Text("Rejected"),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}

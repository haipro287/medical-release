import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';

class SearchUserScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserSearchController userSearchController = Get.put(UserSearchController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "ユーザー検索",
          style: TextStyle(
            color: Colors.black,
            fontFamily: "SF Pro Display",
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        leading: new IconButton(
          icon: SvgPicture.asset('assets/images/back.svg'),
          onPressed: () => Get.back(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          children: [
            userInputSearch(
              context,
              hintText: "searchById".tr,
              textEditingController: userSearchController.searchInput,
              onSearch: userSearchController.search,
            ),
            Obx(
              () => userSearchController.userData["id"].toString() == "NullID"
                  ? Column(
                      children: [
                        SizedBox(
                          height: getHeight(41.15),
                        ),
                        Container(
                          child:
                              SvgPicture.asset("assets/images/no-result.svg"),
                        ),
                        SizedBox(
                          height: getHeight(33.3),
                        ),
                        Text("userNotFound".tr),
                      ],
                    )
                  : Container(),
            ),
          ],
        ),
      ),
    );
  }
}

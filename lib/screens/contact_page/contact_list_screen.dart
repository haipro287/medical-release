import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/contact_page/contact_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
import 'package:medical_chain_mobile_ui/screens/contact_page/search_user_screen.dart';
import 'package:medical_chain_mobile_ui/screens/contact_page/user_saved_screen.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';
import 'package:medical_chain_mobile_ui/widgets/text_box.dart';

class ContactListPage extends StatelessWidget {
  ContactPageController contactPageController =
      Get.put(ContactPageController());
  UserSearchController userSearchController = Get.put(UserSearchController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appBar(context, "contact".tr),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(
          bottom: getHeight(52),
          right: getWidth(24),
        ),
        child: FloatingActionButton(
          backgroundColor: Color(0xFF61B3FF),
          foregroundColor: Colors.white,
          onPressed: () async {
            // print(contactPageController.contactList);
            Get.to(() => SearchUserScreen());
          },
          child: Icon(Icons.add),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            inputSearch(
              context,
              hintText: "searchInput".tr,
              textEditingController: contactPageController.searchInput,
              onSearch: contactPageController.search,
            ),
            SizedBox(
              height: getHeight(12),
            ),
            Obx(
              () => contactPageController.searchList.length == 0
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
                        Text(
                          "userNotFound".tr,
                          style: TextStyle(fontSize: getWidth(17)),
                        ),
                      ],
                    )
                  : Expanded(
                      flex: 1,
                      child: ListView(
                        scrollDirection: Axis.vertical,
                        children: [
                          customBoxHeader('A'),
                          ...contactPageController.searchList.value
                              .map(
                                (e) => GestureDetector(
                                  onTap: () {
                                    print(e.toString());
                                    userSearchController.userData.value = e;
                                    userSearchController.isEditing.value =
                                        false;
                                    print("userDataOfContact: " + e.toString());
                                    Get.to(() => UserSavedScreen());
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(
                                      left: getWidth(15),
                                      right: getWidth(15),
                                    ),
                                    decoration: BoxDecoration(
                                      border: Border(
                                        bottom: BorderSide(
                                          color: Color(0xFFECEFF1),
                                          width: getHeight(1),
                                        ),
                                      ),
                                    ),
                                    height: getHeight(78),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/images/avatar.svg"),
                                        SizedBox(width: getWidth(15)),
                                        Container(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                e["secondaryName"] != ""
                                                    ? e["secondaryName"]
                                                    : getHintText(e),
                                                style: TextStyle(
                                                  fontSize: getWidth(17),
                                                ),
                                              ),
                                              Text(
                                                e["secondaryUsername"] ??
                                                    'Unknown',
                                                style: TextStyle(
                                                    fontSize: getWidth(13),
                                                    color: Color(0xFF838AA2)),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                              )
                              .toList(),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

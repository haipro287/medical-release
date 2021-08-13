import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/user_search_page/user_search_controller.dart';
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
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            userInputSearch(
              context,
              hintText: "氏名、ユーザーID、ニックネーム",
              textEditingController: userSearchController.searchInput,
              onSearch: userSearchController.search(),
            ),
          ],
        ),
      ),
    );
  }
}

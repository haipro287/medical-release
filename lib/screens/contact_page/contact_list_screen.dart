import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/contact_page/contact_page_controller.dart';
import 'package:medical_chain_mobile_ui/screens/contact_page/search_user_screen.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';

class ContactListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ContactPageController contactPageController =
        Get.put(ContactPageController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "ログイン",
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xFF61B3FF),
        foregroundColor: Colors.white,
        onPressed: () {
          print(contactPageController.contactList);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return SearchUserScreen();
              },
            ),
          );
          // Respond to button press
        },
        child: Icon(Icons.add),
      ),
      backgroundColor: Colors.white,
      body: Container(
        child: Column(
          children: [
            inputSearch(
              context,
              hintText: "氏名、ユーザーID、ニックネーム",
              textEditingController: TextEditingController(),
            ),
            SizedBox(
              height: getHeight(9),
            ),
            Container(
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(getHeight(4)),
                border: Border.all(
                  color: Color(0xF2F3F7F2),
                  width: getHeight(1),
                ),
              ),
              height: getHeight(56),
              child: Row(
                children: [
                  SizedBox(width: getWidth(15)),
                  Text(
                    "A",
                  ),
                ],
              ),
              alignment: Alignment.centerLeft,
            ),
            Container(
              margin: EdgeInsets.only(
                left: getWidth(15),
                right: getWidth(15),
              ),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xF2F3F7F2),
                    width: getHeight(3),
                  ),
                ),
              ),
              height: getHeight(78),
              child: Row(
                children: [
                  SvgPicture.asset("assets/images/avatar.svg"),
                  SizedBox(width: getWidth(15)),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("秋原新一 (Akihara Shinichi)"),
                        Text("akiharashinichi1"),
                      ],
                    ),
                  )
                ],
              ),
              alignment: Alignment.centerLeft,
            ),
          ],
        ),
      ),
    );
  }
}

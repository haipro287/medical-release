import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/screens/my_account/my_account_components.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';

class UserSavedScreen extends StatelessWidget {
  final userInfo = Get.put(GlobalController()).user.value;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: screenHeight(),
          color: Color(0xFFf4FaFF),
        ),
        Container(
          height: getHeight(350),
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.fill,
              image: AssetImage('assets/images/my_account_background.png'),
            ),
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: appBar(
            context,
            "myAccount".trParams(),
            GestureDetector(
              onTap: () {},
              child: Container(
                padding: EdgeInsets.all(6),
                child: SvgPicture.asset(
                  'assets/images/delete-icon.svg',
                ),
              ),
            ),
          ),
          body: Container(
            padding: EdgeInsets.only(top: getHeight(30)),
            width: double.infinity,
            height: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: getHeight(70),
                  width: getWidth(70),
                  decoration: BoxDecoration(
                    border: Border.all(
                      width: 1,
                      color: Colors.white,
                    ),
                    shape: BoxShape.circle,
                    color: Color(0xFFD0E8FF),
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Container(
                    margin: EdgeInsets.only(
                      left: getWidth(17),
                      right: getWidth(17),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      bottom: getHeight(4),
                    ),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          width: 1,
                          color: Colors.black12,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: getWidth(17),
                        ),
                        Text(
                          "病院Kの医者さん",
                          style: TextStyle(
                            color: Color(0xFF2F3842),
                            fontSize: getWidth(20),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SvgPicture.asset("assets/images/tick-icon.svg"),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFFFF),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  margin: EdgeInsets.only(
                    top: getHeight(40),
                    left: getWidth(17),
                    right: getWidth(17),
                  ),
                  padding: EdgeInsets.only(
                    top: getHeight(30),
                    left: getWidth(20),
                    right: getWidth(20),
                  ),
                  alignment: Alignment.center,
                  width: getWidth(343),
                  height: getHeight(139),
                  child: Column(
                    children: [
                      myAccountField(
                        myAccountText(('ユーザーID')),
                        myAccountText('${userInfo.id.toString().substring(0, 15)}...'),
                      ),
                      myAccountField(
                        myAccountText(('氏名')),
                        myAccountText('佐藤様 (${userInfo.name.toString()})'),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                    top: getHeight(24),
                  ),
                  width: getWidth(343),
                  child: Column(
                    children: [
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          backgroundColor: Color(0xFFD0E8FF),
                          side: BorderSide(
                            color: Color(0xFFD0E8FF),
                          ),
                          padding: EdgeInsets.only(
                            top: getHeight(14),
                            bottom: getHeight(14),
                          ),
                        ),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/share-icon.svg"),
                            SizedBox(
                              width: getWidth(12),
                            ),
                            Text(
                              "データ共有",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getHeight(14),
                      ),
                      OutlinedButton(
                        style: OutlinedButton.styleFrom(
                            backgroundColor: Color(0xFFD0E8FF),
                            side: BorderSide(
                              color: Color(0xFFD0E8FF),
                            ),
                            padding: EdgeInsets.only(
                              top: getHeight(14),
                              bottom: getHeight(14),
                            )),
                        onPressed: () {},
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset("assets/images/sent-icon.svg"),
                            SizedBox(
                              width: getWidth(12),
                            ),
                            Text(
                              "データ共有",
                              style: TextStyle(
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

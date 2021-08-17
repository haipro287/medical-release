import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';

class HomePageTabScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: getWidth(16)),
      child: ListView(
        children: [
          SizedBox(
            height: getHeight(60),
          ),
          Text(
            "Logo",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: getWidth(20),
            ),
          ),
          SizedBox(
            height: getHeight(40),
          ),
          Wrap(
            spacing: getWidth(13),
            runSpacing: getWidth(10),
            children: [
              Container(
                width: getWidth(165),
                height: getWidth(130),
                decoration: BoxDecoration(
                  color: Color(0xFFF5FAFF),
                  borderRadius: BorderRadius.circular(
                    getWidth(6),
                  ),
                ),
                padding: EdgeInsets.only(
                  left: getWidth(14),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'konichiwa'.tr,
                      style: TextStyle(
                        fontSize: getWidth(17),
                        color: Color(0xFF838AA2),
                      ),
                    ),
                    Text(
                      Get.put(GlobalController()).user.value.name.toString(),
                      style: TextStyle(
                        fontSize: getWidth(24),
                      ),
                    ),
                  ],
                ),
              ),
              actionTab(
                  color: Color(0xFFD0E8FF),
                  icon: "assets/images/share1.svg",
                  tag: "shareData"),
              actionTab(
                  color: Color(0xFFDAD4FF),
                  icon: "assets/images/data.svg",
                  tag: "viewData"),
              actionTab(
                  color: Color(0xFFFFF0D1),
                  icon: "assets/images/share2.svg",
                  tag: "viewSettings"),
              actionTab(
                  color: Color(0xFFF7EBE8),
                  icon: "assets/images/link.svg",
                  tag: "connectService"),
              actionTab(
                  color: Color(0xFFD8F4FF),
                  icon: "assets/images/people.svg",
                  tag: "contact_address"),
              actionTab(
                  color: Color(0xFFD0E8FF),
                  icon: "assets/images/send.svg",
                  tag: "sentRequest"),
              actionTab(
                  color: Color(0xFFF0F7E6),
                  icon: "assets/images/person.svg",
                  tag: "my_account"),
              SizedBox(
                height: getHeight(10),
              ),
            ],
          )
        ],
      ),
    );
  }

  GestureDetector actionTab(
      {required Color color,
      required String icon,
      required String tag,
      Function? function}) {
    return GestureDetector(
      onTap: () {
        if (function != null) {
          function();
        }
      },
      child: Container(
        width: getWidth(165),
        height: getWidth(130),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(
            getWidth(6),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(getWidth(44)),
              child: Container(
                width: getWidth(44),
                height: getWidth(44),
                color: Colors.white,
                padding: EdgeInsets.all(getWidth(9)),
                child: SvgPicture.asset(
                  icon,
                ),
              ),
            ),
            Text(
              tag.tr,
              style: TextStyle(fontSize: getWidth(15)),
            )
          ],
        ),
      ),
    );
  }
}

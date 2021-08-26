import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:get/get.dart';
import 'detail_history_page.dart';

Widget historyDetailComponent({required record}) {
  ShareHistoryController shareHistoryController =
      Get.put(ShareHistoryController());
  return GestureDetector(
    onTap: () {
      shareHistoryController.itemSelected.value = record;
      Get.to(() => DetailHistoryPage());
    },
    child: Container(
      color: Colors.white,
      margin: EdgeInsets.only(
        left: getWidth(16),
        right: getWidth(16),
        bottom: getHeight(20),
      ),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.only(
              right: getWidth(16),
              bottom: getHeight(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/images/jp_${record["status"]}_tag.svg'),
                Text(
                  TimeService.getTimeFormat(record["endTime"], ""),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: getWidth(16),
              bottom: getHeight(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text('userReceived:'),
                SizedBox(
                  width: getWidth(8),
                ),
                Text(
                  getHintText(record),
                  style: TextStyle(
                      fontSize: getWidth(17), fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              left: getWidth(16),
              bottom: getHeight(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('data:'),
                SizedBox(
                  width: getWidth(8),
                ),
                Column(
                  children: List.generate(2, (index) {
                    return Container(
                      margin: EdgeInsets.only(
                        bottom: getHeight(8),
                      ),
                      child: Row(children: [
                        SvgPicture.asset(
                          "assets/images/facebook.svg",
                          width: getWidth(16),
                        ),
                        SizedBox(width: getWidth(8)),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Facebook'),
                            ],
                          ),
                        ),
                      ]),
                    );
                  }),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFFF8F8F9),
                  width: getHeight(3),
                ),
              ),
            ),
            alignment: Alignment.center,
            margin: EdgeInsets.only(
              left: getWidth(16),
              bottom: getHeight(12),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                top: getHeight(15),
                bottom: getHeight(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset("assets/images/calendar.svg"),
                  SizedBox(
                    width: getWidth(8),
                  ),
                  Text(
                    "1週間",
                  ),
                  SizedBox(
                    width: getWidth(14),
                  ),
                  Text("(" + TimeService.getTimeFormat(record["endTime"], "まで") + ")"),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}

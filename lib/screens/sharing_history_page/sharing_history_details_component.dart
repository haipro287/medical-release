import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/global_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/notification/notification_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/share_history_page/share_history_controller.dart';
import 'package:medical_chain_mobile_ui/models/custom_dio.dart';
import 'package:medical_chain_mobile_ui/services/date_format.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/utils/utils.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';

import 'detail_history_page.dart';

Widget historyDetailComponent({required record}) {
  ShareHistoryController shareHistoryController =
      Get.put(ShareHistoryController());
  GlobalController globalController = Get.put(GlobalController());
  List<dynamic> serviceList = record["services"];
  var mode = globalController.historyStatus.value == "SENDING_MODE";
  var subMode = ["sharing", "expired"].contains(record["status"]);
  return Container(
    child: Stack(
      children: [
        GestureDetector(
          onTap: () async {
            if (record["status"] != "invalid") {
              showLoading();
              try {
                var item = await Get.put(NotificationController())
                    .getRequest(id: record["id"]);
                CustomDio customDio = CustomDio();
                var certificate = Get.put(GlobalController())
                    .user
                    .value
                    .certificate
                    .toString();
                customDio.dio.options.headers["Authorization"] = certificate;
                var response = await customDio.get(
                    "/users/${!mode ? record["primaryId"] : record["secondaryId"]}");
                item["isBan"] = !response.data["success"];
                shareHistoryController.itemSelected.value = item;
                Get.back();
                Get.to(() => DetailHistoryPage());
              } catch (e) {
                Get.back();
              }
            }
          },
          child: Container(
            margin: EdgeInsets.only(
              left: getWidth(16),
              right: getWidth(16),
              bottom: getHeight(20),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                getWidth(4),
              ),
              color: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: getHeight(35),
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: getWidth(16),
                    bottom: getHeight(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(mode
                          ? (subMode
                              ? 'dataReceiver'.tr + ':'
                              : 'requestSender'.tr + ':')
                          : (subMode
                              ? 'dataSender'.tr + ':'
                              : 'requestReceived'.tr + ':')),
                      SizedBox(
                        width: getWidth(8),
                      ),
                      Expanded(
                        child: Text(
                          getHintText(record),
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontSize: getWidth(17),
                              fontWeight: FontWeight.w400),
                        ),
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
                      Text('data'.tr + ':'),
                      SizedBox(
                        width: getWidth(8),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: serviceList
                              .map((e) => Container(
                                    margin: EdgeInsets.only(
                                      bottom: getHeight(8),
                                    ),
                                    child: Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(27),
                                          child: Container(
                                            width: getWidth(16),
                                            height: getWidth(16),
                                            child: e["icon"]
                                                    .toString()
                                                    .contains("http")
                                                ? Image.asset(
                                                    e["icon"].toString(),
                                                    fit: BoxFit.cover,
                                                  )
                                                : Image.memory(
                                                    base64Decode(e["icon"]
                                                        .toString()
                                                        .split(",")[1]),
                                                    fit: BoxFit.cover,
                                                  ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: getWidth(8),
                                        ),
                                        Expanded(
                                          child: Text(
                                            upperFirstString(e["name"]),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              .toList(),
                        ),
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
                    right: getWidth(16),
                    bottom: getHeight(12),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: getHeight(15),
                      bottom: getHeight(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset("assets/images/calendar.svg"),
                            SizedBox(
                              width: getWidth(8),
                            ),
                            record["status"] == "expired"
                                ? Text(
                                    TimeService.getTimeFormat(
                                            record["fromTime"], "") +
                                        "～" +
                                        // endTime , bao h noi api that fix sau
                                        TimeService.getTimeFormat(
                                            record["endTime"], ""),
                                    style: TextStyle(fontSize: getWidth(13)),
                                  )
                                : record["status"] == "rejected"
                                    ? Text(
                                        TimeService.getTimeFormat(
                                            record["endTime"], ""),
                                        style:
                                            TextStyle(fontSize: getWidth(13)),
                                      )
                                    : Text(
                                        TimeService.getTimeFormat(
                                            record["fromTime"], ""),
                                        style:
                                            TextStyle(fontSize: getWidth(13)),
                                      ),
                          ],
                        ),
                        record["status"] == "invalid"
                            ? GestureDetector(
                                onTap: () {
                                  showDialog(
                                      context: Get.context!,
                                      barrierColor: Colors.black38,
                                      builder: (builder) {
                                        return Container(
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                  getWidth(5),
                                                ),
                                              ),
                                              child: Material(
                                                color: Colors.white,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16.0)),
                                                child: Container(
                                                  width: MediaQuery.of(
                                                              Get.context!)
                                                          .size
                                                          .width -
                                                      getWidth(16) * 2,
                                                  padding: EdgeInsets.all(
                                                      getWidth(18)),
                                                  child: Column(
                                                    mainAxisSize:
                                                        MainAxisSize.min,
                                                    children: [
                                                      SvgPicture.asset(
                                                        "assets/images/alert_delete.svg",
                                                        width: getWidth(56),
                                                        height: getWidth(56),
                                                      ),
                                                      SizedBox(
                                                        height: getHeight(26),
                                                      ),
                                                      Text(
                                                        "削除してもよろしいでしょうか。",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                            fontSize:
                                                                getWidth(17),
                                                            height: 1.5),
                                                      ),
                                                      SizedBox(
                                                        height: getHeight(40),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Expanded(
                                                            child: Bouncing(
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      getHeight(
                                                                          50),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFE9E9E9),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      getWidth(
                                                                          4),
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "cancel"
                                                                          .tr,
                                                                      style:
                                                                          TextStyle(
                                                                        fontSize:
                                                                            getWidth(17),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ),
                                                                onPress: () {
                                                                  Get.back();
                                                                }),
                                                          ),
                                                          SizedBox(
                                                            width: getWidth(16),
                                                          ),
                                                          Expanded(
                                                            child: Bouncing(
                                                                child:
                                                                    Container(
                                                                  height:
                                                                      getHeight(
                                                                          50),
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    color: Color(
                                                                        0xFFEB5757),
                                                                    borderRadius:
                                                                        BorderRadius
                                                                            .circular(
                                                                      getWidth(
                                                                          4),
                                                                    ),
                                                                  ),
                                                                  child: Center(
                                                                    child: Text(
                                                                      "削除",
                                                                      style: TextStyle(
                                                                          fontSize: getWidth(
                                                                              17),
                                                                          color:
                                                                              Colors.white),
                                                                    ),
                                                                  ),
                                                                ),
                                                                onPress:
                                                                    () async {
                                                                  print("a");
                                                                  if (shareHistoryController
                                                                          .isClickDetele ==
                                                                      false) {
                                                                    Get.back();
                                                                    showLoading();
                                                                    shareHistoryController
                                                                            .isClickDetele =
                                                                        true;
                                                                    try {
                                                                      await shareHistoryController.deleteHistory(
                                                                          item:
                                                                              record);
                                                                      var records = await shareHistoryController.getRecords(shareHistoryController.getStatusFromValue(globalController
                                                                          .recordsTabMode
                                                                          .value));
                                                                      shareHistoryController
                                                                          .searchList
                                                                          .value = records;
                                                                      Get.back();
                                                                      shareHistoryController
                                                                              .isClickDetele =
                                                                          false;
                                                                    } catch (e) {
                                                                      shareHistoryController
                                                                              .isClickDetele =
                                                                          false;
                                                                      Get.back();
                                                                    }
                                                                  }
                                                                }),
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                child: SvgPicture.asset(
                                    "assets/images/delete-icon.svg"),
                              )
                            : Container()
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.topLeft,
          child: Container(
            padding: EdgeInsets.only(
              top: getHeight(4),
              left: getHeight(10),
            ),
            child: SvgPicture.asset(
              'assets/images/jp_${record["status"]}_tag.svg',
              width: getWidth(75),
            ),
          ),
        )
      ],
    ),
  );
}

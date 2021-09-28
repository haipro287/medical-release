import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/list_service_controller.dart';
import 'package:medical_chain_mobile_ui/screens/list_service/view_services.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/utils/utils.dart';
import 'package:medical_chain_mobile_ui/widgets/bounce_button.dart';

Widget switchService(
    {required String? serviceName,
    required String? userName,
    required dynamic isConnected,
    required dynamic icon,
    required int index,
    required String url,
    required String redirectURL,
    // required String callbackUrl,
    // required String redirectUrl,
    String? description}) {
  ListServiceController listServiceController =
      Get.put(ListServiceController());
  return GestureDetector(
    onTap: () {
      String message = getMessage();
      Get.to(() => WebViewPage(
            url: url + "?callbackURL=$redirectURL&message=$message",
          ));
    },
    child: Container(
      height: getHeight(50),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: getWidth(16),
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(27),
            child: Container(
              width: getWidth(27),
              height: getWidth(27),
              child: icon.toString().contains("http")
                  ? Image.asset(
                      icon.toString(),
                      fit: BoxFit.cover,
                    )
                  : Image.memory(
                      base64Decode(icon.toString().split(",")[1]),
                      fit: BoxFit.cover,
                    ),
            ),
          ),
          SizedBox(
            width: getWidth(12),
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  upperFirstString(serviceName ?? ""),
                  style: TextStyle(
                    fontSize: getWidth(17),
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF22262B),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: getHeight(3),
                ),
                userName != null
                    ? Text(
                        userName.toString(),
                        style: TextStyle(
                          fontSize: getWidth(13),
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF878C92),
                        ),
                      )
                    : Container(),
              ],
            ),
          ),
          Bouncing(
              onPress: () {
                if (description != null)
                  Get.bottomSheet(
                    Container(
                        constraints: BoxConstraints(
                            maxHeight:
                                MediaQuery.of(Get.context!).size.height * 0.5),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(
                              getWidth(20),
                            ),
                            topRight: Radius.circular(
                              getWidth(20),
                            ),
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          horizontal: getWidth(16),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                              height: getHeight(35),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(27),
                                      child: Container(
                                        width: getWidth(24),
                                        height: getWidth(24),
                                        child: icon.toString().contains("http")
                                            ? Image.asset(
                                                icon.toString(),
                                                fit: BoxFit.cover,
                                              )
                                            : Image.memory(
                                                base64Decode(icon
                                                    .toString()
                                                    .split(",")[1]),
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: getWidth(12),
                                    ),
                                    Text(
                                      upperFirstString(serviceName ?? ""),
                                      style: TextStyle(
                                        fontSize: getWidth(17),
                                        fontWeight: FontWeight.w400,
                                        color: Color(0xFF22262B),
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    )
                                  ],
                                ),
                                Bouncing(
                                  onPress: () {
                                    Get.back();
                                  },
                                  child: SvgPicture.asset(
                                    "assets/images/cancel.svg",
                                    color: Color(0xFF50555C),
                                    width: getWidth(20),
                                    height: getWidth(20),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: getHeight(27),
                            ),
                            Container(
                              width: double.infinity,
                              height: 1,
                              color: Color(0xFFECECEC),
                            ),
                            SizedBox(
                              height: getHeight(23),
                            ),
                            Expanded(
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                children: [
                                  Text(
                                    description.toString(),
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      fontSize: getWidth(17),
                                    ),
                                  ),
                                  SizedBox(
                                    height: getHeight(5),
                                  )
                                ],
                              ),
                            )
                          ],
                        )),
                    isScrollControlled: true,
                  );
              },
              child: SvgPicture.asset("assets/images/info.svg")),
          // SizedBox(
          //   width: getWidth(18),
          // ),
          GetBuilder<ListServiceController>(
            builder: (listController) {
              if (listController.serviceList.length > 0) {
                return Switch(
                  value: listController.serviceList[index].isConnected ?? true,
                  onChanged: (bool value) async {
                    if (!value) {
                      var a = await listController.disconnectService(
                          serviceId:
                              listController.serviceList[index].id ?? "");
                      if (a) {
                        listController.serviceList[index].isConnected = false;
                      }
                    } else {
                      // listController.update();
                      // listController.serviceList[index].isConnected =
                      //     value;
                      var a = await listController.connectService(
                          serviceId:
                              listController.serviceList[index].id ?? "");
                      if (a) {
                        listController.serviceList[index].isConnected = true;
                      }
                    }
                    listController.update();
                  },
                );
              } else
                return Container();
            },
          ),
          SizedBox(
            width: getWidth(18),
          ),
        ],
      ),
    ),
  );
}

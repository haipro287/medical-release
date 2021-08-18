import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/list_service_controller.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';

Container switchService(
    {required String? serviceName,
    required String? userName,
    required dynamic? isConnected,
    required int? index}) {
  ListServiceController listServiceController =
      Get.put(ListServiceController());
  return Container(
    height: getHeight(42),
    color: Colors.white,
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: getWidth(16),
        ),
        Padding(
          padding: EdgeInsets.only(
            bottom: getHeight(10),
          ),
          child: SvgPicture.asset(
              'assets/images/${serviceName?.toLowerCase()}.svg'),
        ),
        SizedBox(
          width: getWidth(12),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serviceName ?? "",
              style: TextStyle(
                fontSize: getWidth(17),
                fontWeight: FontWeight.w400,
                color: Color(0xFF22262B),
              ),
            ),
            SizedBox(
              height: getHeight(3),
            ),
            Text(
              userName ?? "",
              style: TextStyle(
                fontSize: getWidth(13),
                fontWeight: FontWeight.w400,
                color: Color(0xFF878C92),
              ),
            ),
          ],
        ),
        Spacer(),
        Obx(
          () => CupertinoSwitch(
            value: listServiceController.serviceList[index ?? 0].isConnected ?? true,
            onChanged: (bool value) async {
              if (!value) {
                var a = await listServiceController.disconnectService(serviceId: '123');
                if (a) {
                  listServiceController.serviceList[index ?? 0].isConnected = false;
                }
              } else {
                listServiceController.serviceList[index ?? 0].isConnected = value;
              }
            },
          ),
        ),
        SizedBox(
          width: getWidth(18),
        ),
      ],
    ),
  );
}

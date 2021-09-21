import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/list_service_controller.dart';
import 'package:medical_chain_mobile_ui/utils/common-function.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';

Container switchService(
    {required String? serviceName,
    required String? userName,
    required dynamic isConnected,
    required dynamic icon,
    required int index}) {
  ListServiceController listServiceController =
      Get.put(ListServiceController());
  return Container(
    height: getHeight(50),
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
          child: icon.toString().contains('http')
              ? Container(
                  width: getWidth(16), child: Image.network(icon.toString()))
              : SvgPicture.asset(
                  'assets/images/avatar.svg',
                  width: getWidth(16),
                ),
        ),
        SizedBox(
          width: getWidth(12),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              upperFirstString(serviceName ?? ""),
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
        GetBuilder<ListServiceController>(
          builder: (listController) {
            if (listController.serviceList.length > 0) {
              return Switch(
                value: listController.serviceList[index].isConnected ?? true,
                onChanged: (bool value) async {
                  if (!value) {
                    var a = await listController.disconnectService(
                        serviceId: listController.serviceList[index].id ?? "");
                    if (a) {
                      listController.serviceList[index].isConnected = false;
                    }
                  } else {
                    // listController.update();
                    // listController.serviceList[index].isConnected =
                    //     value;
                    var a = await listController.connectService(
                        serviceId: listController.serviceList[index].id ?? "");
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
  );
}

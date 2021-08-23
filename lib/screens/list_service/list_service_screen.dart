import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/list_service_controller.dart';
import 'package:medical_chain_mobile_ui/models/service.dart';
import 'package:medical_chain_mobile_ui/screens/list_service/list_service_components.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';

class ListServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ListServiceController listServiceController =
        Get.put(ListServiceController());
    List serviceList = listServiceController.serviceList;

    return Scaffold(
      appBar: appBar(context, 'connectService'.tr),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Color(0xFFf6f7fb),
        margin: EdgeInsets.only(top: getHeight(20)),
        child: SingleChildScrollView(
          child: FutureBuilder<List<Service>>(
              future: listServiceController.getServiceList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<Service> list = snapshot.data ?? [];
                  for (var i = 0; i < list.length; ++i) {
                    listServiceController.serviceList.add(list[i]);
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                          left: getWidth(16),
                          top: getHeight(24),
                          bottom: getHeight(12),
                        ),
                        child: Text(
                          'connectService'.tr,
                        ),
                      ),
                      Container(
                        height: getHeight(24),
                        color: Colors.white,
                      ),
                      ...List.generate(listServiceController.serviceList.length,
                          (index) {
                        return Column(children: [
                          switchService(
                            serviceName:
                                serviceList[index].name[0].toUpperCase() +
                                    serviceList[index].name.substring(1),
                            userName: serviceList[index].username,
                            isConnected: serviceList[index].isConnected,
                            index: index,
                          ),
                          index < serviceList.length - 1
                              ? Container(
                                  color: Colors.white,
                                  padding: EdgeInsets.only(
                                    top: getHeight(12),
                                    bottom: getHeight(12),
                                  ),
                                  child: Container(
                                    width: screenWidth(),
                                    color: Colors.white,
                                    child: SvgPicture.asset(
                                      'assets/images/separate_line.svg',
                                      width: getWidth(343),
                                    ),
                                  ),
                                )
                              : Container(
                                  height: getHeight(24),
                                  color: Colors.white,
                                )
                        ]);
                      }),
                    ],
                  );
                } else
                  return Text("");
              }),
        ),
      ),
    );
  }
}

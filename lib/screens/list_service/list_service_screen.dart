import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:medical_chain_mobile_ui/controllers/home_page/home_page_controller.dart';
import 'package:medical_chain_mobile_ui/controllers/service_list/list_service_controller.dart';
import 'package:medical_chain_mobile_ui/models/service.dart';
import 'package:medical_chain_mobile_ui/screens/home_page/home_page_screen.dart';
import 'package:medical_chain_mobile_ui/screens/list_service/list_service_components.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';
import 'package:medical_chain_mobile_ui/widgets/app_bar.dart';
import 'package:medical_chain_mobile_ui/widgets/input.dart';

class ListServiceScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ListServiceController listServiceController =
        Get.put(ListServiceController());
    List serviceList = listServiceController.serviceList;

    return WillPopScope(
      onWillPop: () async {
        Get.put(HomePageController()).currentPage.value = 0;
        Get.offAll(() => HomePageScreen(), transition: Transition.leftToRight);
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appBar(context, 'connectService'.tr, null, true),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.white,
          margin: EdgeInsets.only(top: getHeight(20)),
          child: FutureBuilder<List<Service>>(
              future: listServiceController.getServiceList(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  // List<Service> list = snapshot.data ?? [];
                  // listServiceController.serviceList.value = list;
                  // for (var i = 0; i < list.length; ++i) {
                  //   listServiceController.serviceList.add(list[i]);
                  // }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            inputSearch(
                              context,
                              hintText: "searchInput".tr,
                              textEditingController:
                                  listServiceController.searchService,
                              onSearch: () async {
                                await listServiceController.getServiceList();
                              },
                            ),
                            SizedBox(
                              height: getHeight(12),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        color: Color(0xFFf6f7fb),
                        padding: EdgeInsets.only(
                          left: getWidth(16),
                          top: getHeight(16),
                          bottom: getHeight(12),
                        ),
                        width: double.infinity,
                        child: Text(
                          'serviceList'.tr,
                          style: TextStyle(fontSize: getWidth(17)),
                        ),
                      ),
                      Container(
                        height: getHeight(24),
                        color: Colors.white,
                      ),
                      Obx(() {
                        return Expanded(
                          child: RefreshIndicator(
                            onRefresh: () async {
                              await listServiceController.getServiceList();
                            },
                            child: LazyLoadScrollView(
                              onEndOfPage: () async {
                                if (listServiceController.offset <
                                    listServiceController.totalPage)
                                  await listServiceController
                                      .getMoreServiceList();
                              },
                              child: ListView(
                                physics: BouncingScrollPhysics(),
                                children: [
                                  ...listServiceController.serviceList
                                      .map((service) {
                                    return Column(children: [
                                      switchService(
                                          redirectURL:
                                              service.redirectURL.toString(),
                                          url: service.url.toString(),
                                          serviceName:
                                              service.name![0].toUpperCase() +
                                                  service.name!.substring(1),
                                          userName: service.username,
                                          isConnected: service.isConnected,
                                          index: listServiceController
                                              .serviceList
                                              .indexOf(service),
                                          icon: service.icon,
                                          description: service.description),
                                      listServiceController.serviceList
                                                  .indexOf(service) <
                                              serviceList.length - 1
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
                                  })
                                ],
                              ),
                            ),
                          ),
                        );
                      })
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

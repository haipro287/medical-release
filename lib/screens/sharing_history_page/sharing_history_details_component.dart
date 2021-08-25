import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';

Container HistoryDetailComponent({required status}) {
  return Container(
    color: Colors.white,
    margin: EdgeInsets.only(
      left: getWidth(16),
      right: getWidth(16),
      top: getHeight(20),
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
              SvgPicture.asset('assets/images/jp_${status}_tag.svg'),
              Text(
                "2021/04/13 07:53",
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
              Text('共有先:'),
              SizedBox(
                width: getWidth(8),
              ),
              Text(
                "工藤新一（クドウシンイチ）",
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
              Text('データ:'),
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
                Text('(2021/04/13 07:53まで)'),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

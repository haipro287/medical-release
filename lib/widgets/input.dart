import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medical_chain_mobile_ui/utils/config.dart';

Container inputPassword(BuildContext context, TextEditingController controller,
    String hintText, bool isHide, Function changeHide) {
  return Container(
    height: getHeight(56),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(getHeight(4)),
      border: Border.all(
        color: Color(0xFFE7E8EA),
        width: getHeight(1),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
              style: TextStyle(fontSize: getWidth(16)),
              controller: controller,
              obscureText: isHide,
              decoration: InputDecoration(
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                labelText: hintText,
                contentPadding: EdgeInsets.only(left: getWidth(16)),
                labelStyle:
                    TextStyle(color: Color(0xFF878C92), fontSize: getWidth(16)),
              )),
        ),
        IconButton(
            onPressed: () {
              changeHide();
            },
            icon: Icon(
              isHide ? Icons.remove_red_eye_sharp : Icons.panorama_fish_eye,
              size: 24,
            ))
      ],
    ),
  );
}

Container inputRegular(BuildContext context,
    {required String hintText,
    required TextEditingController textEditingController}) {
  return Container(
    height: getHeight(56),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(getHeight(4)),
      border: Border.all(
        color: Color(0xFFE7E8EA),
        width: getHeight(1),
      ),
    ),
    child: Row(
      children: [
        Expanded(
          child: TextFormField(
            controller: textEditingController,
            style: TextStyle(fontSize: getWidth(16)),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              labelText: hintText,
              contentPadding:
                  EdgeInsets.only(left: getWidth(16), right: getWidth(16)),
              labelStyle:
                  TextStyle(color: Color(0xFF878C92), fontSize: getWidth(16)),
            ),
          ),
        ),
      ],
    ),
  );
}

Container inputSearch(BuildContext context,
    {required String hintText,
    required TextEditingController textEditingController}) {
  return Container(
    height: getHeight(56),
    decoration: BoxDecoration(
      color: Colors.black12,
      borderRadius: BorderRadius.circular(getHeight(4)),
      border: Border.all(
        color: Color(0xF2F3F7F2),
        width: getHeight(1),
      ),
    ),
    margin: EdgeInsets.only(
      right: getWidth(16),
      left: getWidth(16),
    ),
    child: Row(
      children: [
        SizedBox(
          width: getWidth(16),
        ),
        SvgPicture.asset("assets/images/search-icon.svg"),
        Expanded(
          child: TextFormField(
            controller: textEditingController,
            style: TextStyle(fontSize: getWidth(16)),
            decoration: InputDecoration(
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              labelText: hintText,
              contentPadding:
                  EdgeInsets.only(left: getWidth(16), right: getWidth(16)),
              labelStyle:
                  TextStyle(color: Color(0xFF878C92), fontSize: getWidth(16)),
            ),
          ),
        ),
      ],
    ),
  );
}

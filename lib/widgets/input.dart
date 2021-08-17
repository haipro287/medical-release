import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:medical_chain_mobile_ui/screens/contact_page/user_saved_screen.dart';
import 'package:medical_chain_mobile_ui/screens/scanQR/scan_QR_screen.dart';
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

Container inputSearch(
  BuildContext context, {
  required String hintText,
  required TextEditingController textEditingController,
  required dynamic onSearch,
}) {
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
        GestureDetector(
          onTap: () {
            onSearch();
          },
          child: SvgPicture.asset("assets/images/search-icon.svg"),
        ),
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

Container userInputSearch(
  BuildContext context, {
  required String hintText,
  required TextEditingController textEditingController,
  required dynamic onSearch,
}) {
  return Container(
    height: getHeight(56),
    margin: EdgeInsets.only(
      right: getWidth(16),
      left: getWidth(16),
    ),
    child: Row(
      textDirection: TextDirection.ltr,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(getHeight(4)),
            border: Border.all(
              color: Color(0xF2F3F7F2),
              width: getHeight(1),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: getWidth(16),
              ),
              GestureDetector(
                onTap: () async {
                  var data = await onSearch();
                  if (data != null) Get.to(() => UserSavedScreen());
                },
                child: SvgPicture.asset("assets/images/search-icon.svg"),
              ),
              SizedBox(
                width: getWidth(240),
                height: getHeight(56),
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
                    contentPadding: EdgeInsets.only(
                        left: getWidth(16), right: getWidth(16)),
                    labelStyle: TextStyle(
                        color: Color(0xFF878C92), fontSize: getWidth(16)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: getWidth(16),
        ),
        GestureDetector(
          onTap: () async {
            Get.to(() => ScanQRScreen(
                  type: "scan",
                ));
          },
          child: SvgPicture.asset("assets/images/qrcode-icon.svg"),
        ),
      ],
    ),
  );
}

Container inputSearchWithQrCode(
  BuildContext context, {
  required String hintText,
  required TextEditingController textEditingController,
  required dynamic onSearch,
}) {
  return Container(
    height: getHeight(56),
    margin: EdgeInsets.only(
      right: getWidth(16),
      left: getWidth(16),
    ),
    child: Row(
      textDirection: TextDirection.ltr,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.black12,
            borderRadius: BorderRadius.circular(getHeight(4)),
            border: Border.all(
              color: Color(0xF2F3F7F2),
              width: getHeight(1),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: getWidth(16),
              ),
              GestureDetector(
                onTap: () async {
                  var data = await onSearch();
                  if (data != null) Get.to(() => UserSavedScreen());
                },
                child: SvgPicture.asset("assets/images/search-icon.svg"),
              ),
              SizedBox(
                width: getWidth(240),
                height: getHeight(56),
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
                    contentPadding: EdgeInsets.only(
                        left: getWidth(16), right: getWidth(16)),
                    labelStyle: TextStyle(
                        color: Color(0xFF878C92), fontSize: getWidth(16)),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: getWidth(16),
        ),
        GestureDetector(
          onTap: () async {
            Get.to(() => ScanQRScreen());
          },
          child: SvgPicture.asset("assets/images/qrcode-icon.svg"),
        ),
      ],
    ),
  );
}

Container inputWithHint(BuildContext context,
    {required String hintText,
    required String labelText,
    required String initialText,
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
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              labelText: labelText,
              hintText: hintText,
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

Container inputDate(BuildContext context,
    {required String hintText,
    required String labelText,
    required TextEditingController textEditingController}) {
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (picked != null) {
      textEditingController.text = picked.year.toString() +
          '年' +
          picked.month.toString() +
          '月' +
          picked.day.toString() +
          '日';
    }
  }

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
            readOnly: true,
            onTap: () {
              _selectDate(context);
            },
            controller: textEditingController,
            style: TextStyle(fontSize: getWidth(16)),
            decoration: InputDecoration(
              suffixIcon: ImageIcon(
                AssetImage('assets/images/calendar.png'),
                color: Color(0xFF757A80),
              ),
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              labelText: labelText,
              hintText: hintText,
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

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_lesson05/resources/strings.dart';

MyAppBar() {
  return AppBar(
      automaticallyImplyLeading: false,
      title: const Text(
        APPBAR_TITLE,
        style: TextStyle(
          fontSize: 20,
        ),
      ),
      centerTitle: true,
      backgroundColor: Colors.green);
}

// Widget trả về hai cái tên screen
Widget screenTitleWidget({required String title}) {
  return Text(title,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 19));
}

Widget rowTitleWidget({required String title}) {
  return SizedBox(
    width: Get.width * 0.36,
    child: Text(
      title,
      style: const TextStyle(fontSize: 15),
    ),
  );
}

Widget textInputWidget(
    {required focusNode,
    required String label,
    required String hintText,
    required controller}) {
  return Container(
    padding: const EdgeInsets.only(top: 10),
    child: Row(
      children: [
        // Một dòng khi hiển thị thông tin
        // Thông tin mục. VD: Tên khách hàng, Số lượng sách
        rowTitleWidget(title: label),

        // TextField để nhập dữ liệu
        SizedBox(
            width: Get.width * 0.5,
            child: TextField(
              focusNode: focusNode,
              controller: controller,
              decoration: InputDecoration(
                hintText: hintText,
              ),
            ))
      ],
    ),
  );
}

Widget homeScreenButton({required String label, onPressed}) {
  return TextButton(
      onPressed: onPressed,
      child: Container(
        color: Colors.grey,
        width: Get.width * 0.254,
        child: Container(
            padding: const EdgeInsets.all(5),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 13, color: Colors.black),
            )),
      ));
}

Widget numberWidget({required int number}) {
  return SizedBox(
      width: Get.width * 0.4,
      child: Text(number.toString(), style: TextStyle(fontSize: 20)));
}

HienDuLieu({required String title, required getInfo}) {
  return FutureBuilder<int>(
      future: getInfo,
      builder: (context, snapshot) {
        // snapshot đại diện cho data
        // Ở đây thì chính là cái String

        if (snapshot.hasError) {
          return Center(
            child: const Text(LOAD_DATA_ERROR),
          );
        }

        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        }

        int data = snapshot.data!;
        return Container(
            child: Row(
          children: [rowTitleWidget(title: title), numberWidget(number: data)],
        ));
      });
}

import 'package:flutter/material.dart';

class TextInputWidget extends StatelessWidget {
  final String labelText;
  final String hintText;
  final TextEditingController controller;

  const TextInputWidget(
      {Key? key, required this.labelText,
      required this.hintText,
      required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Hình dung cái này mặc dù là danh từ nhưng lại là phương thức
    // Nên phải đặt tên viết thường đầu tên và giống với phương thức
    const outlineInputBorder = OutlineInputBorder();
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 10),
      child: TextField(
        controller: controller, // TextField thì phải có controller!
        decoration: InputDecoration(
          border: outlineInputBorder,
          labelText: labelText,
          hintText: hintText,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:lesson06/resources/widgets/text_widget.dart';

class InformationWidget extends StatelessWidget {
  final String userNameContent;
  final String ageContent;

  const InformationWidget(
      {Key? key, required this.userNameContent, required this.ageContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("build again");
    return Container(
      padding: const EdgeInsets.only(left: 10, top: 15, right: 10, bottom: 10),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(20),
          // cách so với container, margin là cách so với lề
          child: Column(
            children: [
              const Text("Thông tin"),
              const SizedBox(height: 20),
              TextWidget(labelText: "Họ và tên", content: userNameContent),
              const SizedBox(height: 10), // Chỉ đơn giản là một ô trắng
              TextWidget(labelText: "Tuổi", content: ageContent)
            ],
          ),
        ),
      ),
    );
  }
}

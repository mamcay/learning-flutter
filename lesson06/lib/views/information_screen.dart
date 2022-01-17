import 'package:flutter/material.dart';
import 'package:lesson06/resources/widgets/information_widget.dart';

class InformationScreen extends StatelessWidget {
  final String userName;
  final String age;

  const InformationScreen({Key? key, required this.userName, required this.age}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Information"),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Center(
            child: InformationWidget(
                userNameContent: userName, ageContent: age)),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String labelText;
  final String content;

  const TextWidget(
      {Key? key, required this.labelText, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(labelText + ': ',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        const SizedBox(width: 5),
        Text(content),
      ],
    );
  }
}

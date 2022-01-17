import 'package:flutter/material.dart';
class ConfirmationButton extends StatelessWidget {
  // ignore: prefer_typing_uninitialized_variables
  final onPressed;
  final String labelButton;

  const ConfirmationButton({ Key? key, this.onPressed, required this.labelButton}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(labelButton));
  }
}

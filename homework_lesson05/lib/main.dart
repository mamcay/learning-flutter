import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:homework_lesson05/screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const GetMaterialApp(
      title: 'HOMEWORK LESSON05',
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

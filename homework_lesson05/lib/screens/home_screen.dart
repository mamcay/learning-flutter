/*
  Màn hình ban đầu vào
  Chương trình bán hàng sách online
  Thông tin hoá đơn
*/

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_lesson05/resources/common_widgets.dart';
import 'package:homework_lesson05/resources/strings.dart';
import 'package:homework_lesson05/screens/statistic_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController? userNameController, numberOfBooksController;
  bool isVip = false;
  int totalBill = 0;
  FocusNode? myFocusNode;
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userNameController = TextEditingController();
    numberOfBooksController = TextEditingController();
    myFocusNode = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    userNameController!.dispose();
    numberOfBooksController!.dispose();
    myFocusNode!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: SingleChildScrollView(
        child: Container(
          height: Get.height,
          width: Get.width,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Phần chứa thông tin hoá đơn

              // Text Thông tin hoá đơn
              screenTitleWidget(title: BILL_INFORMATION),

              // TextField Nhập tên khách hàng
              textInputWidget(
                  focusNode: myFocusNode,
                  label: USERNAME,
                  hintText: INPUT_USERNAME,
                  controller: userNameController),

              // Text Field Số lượng sách
              textInputWidget(
                  focusNode: null,
                  label: NUMBER_OF_BOOKS,
                  hintText: INPUT_NUMBER_OF_BOOKS,
                  controller: numberOfBooksController),

              // ô tick khách hàng VIP hay không
              Row(children: [
                rowTitleWidget(title: ''),
                Checkbox(
                  checkColor: Colors.white,
                  activeColor: Colors.red,
                  value: isVip,
                  onChanged: (bool? value) {
                    setState(() {
                      isVip = value!;
                    });
                  },
                ),
                rowTitleWidget(title: VIP_CUSTOMER)
              ]),

              // Thành tiền -> một ô chứa số tiền: 20.000 * số sách (vip -10%)
              Row(children: [
                rowTitleWidget(title: AMOUNT),
                Container(
                  width: Get.width * 0.5,
                  color: Colors.grey,
                  child: Text(
                    totalBill.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                )
              ]),

              SizedBox(height: 20),

              // 3 button TÍNH TT / TIẾP / THỐNG KÊ
              Container(
                  child: Row(
                children: [
                  homeScreenButton(label: CALCULATE, onPressed: _calculate),
                  homeScreenButton(label: NEXT, onPressed: _nextBill),
                  homeScreenButton(
                      label: STATISTIC,
                      onPressed: () {
                        Get.to(StatisticScreen());
                      })
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }

  _calculate() {
    setState(() {
      try {
        int numberOfBooks = int.parse(numberOfBooksController!.text);
        totalBill = numberOfBooks * 20000;
        if (isVip) {
          totalBill = numberOfBooks * 200 * 90;
        }
      } catch (e) {
        print("Sai định dạng số lượng sách nhập vào!");
        totalBill = 0;
      }
    });
  }

  _storeInformation(
      {required String userName,
      required int numberOfBooks,
      required int totalBill,
      required bool isVip}) async {
    final SharedPreferences prefs = await _prefs;
    int x = await prefs.getInt(userName) ?? 0;
    if (x == 0) {
      int numberOfCustomers = await prefs.getInt(KH) ?? 0;
      prefs.setInt(KH, numberOfCustomers + 1);
      if (isVip) {
        int numberOfVips = await prefs.getInt(NUMBER_VIP) ?? 0;
        prefs.setInt(NUMBER_VIP, numberOfVips + 1);
      }
    }
    await prefs.setInt(userName, x + numberOfBooks);
    // key: userName
    // value: update số lượng!

    int sum = await prefs.getInt(SUM_AMOUNT) ?? 0;
    await prefs.setInt(SUM_AMOUNT, sum + totalBill);

    print("Save Information!");
  }

  _nextBill() {
    setState(() {
      try {
        _storeInformation(
            userName: userNameController!.text,
            numberOfBooks: int.parse(numberOfBooksController!.text),
            totalBill: totalBill,
            isVip: isVip);
      } catch (e) {
        print(e);
      }

      numberOfBooksController!.clear();
      userNameController!.clear();
      totalBill = 0;
      isVip = false;
      myFocusNode!.requestFocus();
    });
  }
}

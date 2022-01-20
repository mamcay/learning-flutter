import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:homework_lesson05/resources/common_widgets.dart';
import 'package:homework_lesson05/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticScreen extends StatefulWidget {
  const StatisticScreen({Key? key}) : super(key: key);

  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int>? numberOfCustomers, numberOfVips, total;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInformation();
  }

  getInformation() {
    print("Bắt đầu lấy dữ liệu từ Preference Database!");
    // Số khách hàng
    numberOfCustomers = _prefs.then((SharedPreferences? pref) {
      return (pref!.getInt(KH)) ?? 0;
    });

    // Số khách hàng Vip
    numberOfVips = _prefs.then((SharedPreferences? pref) {
      return (pref!.getInt(NUMBER_VIP)) ?? 0;
    });

    // Tổng doanh thu
    total = _prefs.then((SharedPreferences? pref) {
      return (pref!.getInt(SUM_AMOUNT)) ?? 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            screenTitleWidget(title: THONG_KE),
            Container(
                width: Get.width,
                padding: const EdgeInsets.only(top: 20),
                child: Column(children: [
                  HienDuLieu(title: KH, getInfo: numberOfCustomers),
                  HienDuLieu(title: NUMBER_VIP, getInfo: numberOfVips),
                  HienDuLieu(title: SUM_AMOUNT, getInfo: total)
                ])),
            SizedBox(height: 20),
            Container(
              alignment: Alignment.bottomRight,
              child: IconButton(
                  onPressed: () async {
                    bool flag = false;
                    await showDialog<String>(
                        context: context,
                        builder: (BuildContext context) => AlertDialog(
                              title: const Text(EXIT),
                              content: const Text(EXIT_DIS),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, 'Cancel'),
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {Navigator.pop(context, 'OK'); flag = true;},
                                  child: const Text('OK'),
                                ),
                              ],
                            ));
                    
                    if (flag) {
                      Navigator.pop(context);
                    }
                  },
                  icon: Icon(Icons.exit_to_app, size: 30)),
            )
          ],
        ),
      ),
    );
  }
}

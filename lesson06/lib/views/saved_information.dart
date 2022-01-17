// Ý tưởng là dữ liệu sẽ được load lên trước khi build màn hình!
// => Nghĩ đến initState()
// => statefulWidget để có hàm initState!!!
// Cách suy nghĩ

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesson06/resources/strings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedInformation extends StatefulWidget {
  const SavedInformation({Key? key}) : super(key: key);

  @override
  _SavedInformationState createState() => _SavedInformationState();
}

class _SavedInformationState extends State<SavedInformation> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<String>? information;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(SAVED_DATA),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                // Get.back();
                // Nó push vào nên khi back thì nó sẽ không phải build lại!
                Get.back();
              },
              icon: const Icon(Icons.arrow_back_ios_outlined))),
      body: SizedBox(
          height: Get.height, // Đây là công dụng khi dùng GetX!!!
          width: Get.width,
          child: FutureBuilder<String>(
              // Cái này để nó đỡ báo lỗi!
              future: information,
              builder: (context, snapshot) {
                // snapshot đại diện cho data
                // Ở đây thì chính là cái String

                if (snapshot.hasError) {
                  return const Center(
                    child: Text(LOAD_DATA_ERROR),
                  );
                }

                if (!snapshot.hasData) {
                  // Nút quay tròn load dữ liệu
                  return const Center(child: CircularProgressIndicator());
                }

                String userNameAge = snapshot.data!;
                return Card(
                  child: Center(
                    child: Text(userNameAge),
                  ),
                );
              })),
    );
  }

  getInformation() {
    print("Bắt đầu lấy dữ liệu từ Preference Database!");
    information = _prefs.then((SharedPreferences? pref) {
      return (pref!.getString('information')) ?? NOT_SAVED_DATA;
      // như dạng dict thì key là kiểu string nên mới cần ngoặc kép đó!
    });
  }
}

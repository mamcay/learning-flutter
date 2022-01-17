// Nằm trong thư mục views chứa các màn hình
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lesson06/controllers/information_controller.dart';
import 'package:lesson06/resources/strings.dart';
import 'package:lesson06/resources/widgets/information_widget.dart';
import 'package:lesson06/resources/widgets/text_input_widget.dart';
import 'package:lesson06/views/saved_information.dart';
// import 'package:lesson06/views/information_screen.dart';
import 'package:lesson06/views/state_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
// 1. Tạo ra State , 2. Gán State - Context , context đại diện cho 1 widget
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController? usernameController, birthYearController;
  String userName = NOT_DEFINED;
  String age = NOT_DEFINED;

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

// 3 . khởi tạo state
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    usernameController = TextEditingController();
    birthYearController = TextEditingController();
    // 1. khởi tạo state
    // 2. được dùng để đặt các lệnh thực thi trước khi build : load dữ liệu từ cơ sở dữ liệu
    // 3. context không hoạt động
  }

  // 4. Chạy khi load Dependency và khi Dependency thay đổi , lúc này Widget có context
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }

  // 6. Gọi khi Widget configuration thay đổi
  @override
  void didUpdateWidget(covariant HomeScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  //8 . Xoá State khỏi Tree , xảy ra khi huỷ widget đó
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
  }

  // 9. huỷ state đi
  @override
  void dispose() {
    // TODO: implement dispose
    print("Hàm dispose được chaỵ, state bị xoá");
    if (!mounted) {
      print("Biến mounted là false ");
    }

    super.dispose();
    usernameController!.dispose();
    birthYearController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("Hàm build được chạy ");

    return Scaffold(
        appBar: AppBar(
          title: const Text(USER_INFORMATION),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                // Tên Widget
                TextInputWidget(
                    labelText: USER_NAME,
                    hintText: USER_NAME_HERE,
                    controller: usernameController!),
                // Năm sinh Widget
                TextInputWidget(
                    labelText: BIRTH_YEAR,
                    hintText: BIRT_YEAR_HERE,
                    controller: birthYearController!),
                    
                // Xac nhan Buttons
                ElevatedButton(
                    onPressed: () {
                      // 7. Hàm setState : Build lại toàn bộ các Widget , kể cả các widget không liên quan
                      userName = usernameController!.text;
                      age = (DateTime.now().year -
                              int.parse(birthYearController!.text))
                          .toString();

                      Get.put(InformationController())
                          .updateInformation(userName: userName, age: age);

                      storeInformation(userName: userName, age: age);
                    },
                    child: Text(CONFIRM)),

                // Information Widget
                InformationWidget(
                    userNameContent: Get.put(InformationController()).userName,
                    ageContent: Get.put(InformationController()).age),
                
                // Next Page Button Widget
                TextButton(
                    onPressed: () {
                      var route = MaterialPageRoute(
                          builder: (context) =>
                              StateWidget(userName: userName, age: age));
                      Navigator.push(context, route);
                    },
                    child: Text(NEXT_PAGE)),
                
                TextButton(
                    onPressed: () {
                      Get.to(SavedInformation());
                    },
                    child: Text(VIEW_SAVED_INFORMATION)),
              ],
            ),
          ),
        ));
  }

  // lưu thông tin vào sharedpreference ( key: value ) ; int , double , String , bool
  storeInformation({required String userName, required String age}) async {
    final SharedPreferences prefs = await _prefs;
    await prefs.setString(
        "information", USER_NAME + ":" + userName + "\n" + AGE + ":" + age);
    print("Saved Information");
  }
}

import 'package:get/get.dart';

class InformationController extends GetxController {

  String userName = "Chưa cập nhật";
  String age = "Chưa cập nhật" ;

  updateInformation({required String userName, required String age}){
    this.userName = userName;
    this.age = age;
    update();
  }
}
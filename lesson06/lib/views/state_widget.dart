import 'package:flutter/material.dart';
import 'package:lesson06/resources/widgets/information_widget.dart';

class StateWidget extends StatefulWidget {
  final String userName;
  final String age;
  // Cần truyền hai dữ liệu này xuống nếu không sẽ bị báo lỗi!
  
  const StateWidget({Key? key, required this.userName, required this.age}) : super(key: key);
  
  // 1. tạo ra state
  // 2. gán State với Context
  // context đại diện cho một Widget

  @override
  _StateWidgetState createState() => _StateWidgetState();
}

class _StateWidgetState extends State<StateWidget> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Không được gọi thì vẫn chạy ngầm
    // 1. khởi tạo state
    // 2. được dùng để đặt các lệnh thực thi trước khi build
    // VD: load dữ liệu từ cơ sở dữ liệu
    // 3. context ở đây không hoạt động!
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    // Chạy khi load Dependency và khi Dependency thay đổi
    // lúc này Widget có context
  }

  // Gọi khi Widget configuration thay đổi
  @override
  void didUpdateWidget(covariant StateWidget oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
  }

  // Xoá state khỏi Tree, xảy ra khi huỷ Widget đó 
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    // Xoá state khỏi Tree
    // xảy ra khi chuyển màn hình, chuyển từ widget này sang widget khác
  }

  /*
    @override
    Widget build(BuildContext context) {
      // Hàm build

      if (mounted) {
        // do smth
      }

      return Container();
    }
  */

  
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
                userNameContent: widget.userName, 
                // Cách lấy, vì phải truyền từ trên xuống
                // Với stateless như ban đầu là cùng class nên cứ thế dùng thôi
                // Còn đây là khác class nên cần truyền xuống!
                ageContent: widget.age
            )),
      ),
    );
  }
}

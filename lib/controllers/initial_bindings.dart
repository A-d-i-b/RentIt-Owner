// initial bindings
import 'package:get/get.dart';
import 'package:househunt/controllers/user_controller.dart';

class Init extends Bindings {
  @override
  void dependencies() {
    Get.put(UserController());
  }
}

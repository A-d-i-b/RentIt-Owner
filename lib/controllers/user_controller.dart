import 'package:get/get.dart';
import 'package:househunt/models/user_model.dart';

class UserController extends GetxController {
  Rx<UserModel> user =
      UserModel(id: 0, firstName: 'Loading', lastName: '', phone: '...').obs;

  String jwt = '';

  set JWT(String token) {
    jwt = token;
  }

  void setUser(Map<String, dynamic> data) {}

  // @override
  // void onReady() async {
  //   final userRes = await getJsonFromAsset('assets/data/user.json');

  //   user.update((val) {
  //     if (val == null) return;
  //     val.id = userRes['id'];
  //     val.firstName = userRes['firstName'];
  //     val.lastName = userRes['lastName'];
  //     val.phone = userRes['phone'];
  //     val.imageUrl = userRes['image_url'];
  //   });

  //   super.onReady();
  // }

  void setUserFromJson(Map<String, dynamic> data) {
    user.update((val) {
      if (val == null) return;
      val.id = data['id'];
      val.firstName = data['firstName'];
      val.lastName = data['lastName'];
      val.phone = data['phone'];
      val.imageUrl = data['image_url'];
    });
  }
}

import 'package:get/get.dart';
import 'package:househunt/models/user_model.dart';
import 'package:househunt/utils/file_utils.dart';

class UserController extends GetxController {
  Rx<UserModel> user =
      UserModel(id: 0, name: 'Loading', address: '...', phone: '...').obs;

  @override
  void onReady() async {
    final userRes = await getJsonFromAsset('assets/data/user.json');

    user.update((val) {
      if (val == null) return;
      val.id = userRes['id'];
      val.name = userRes['name'];
      val.address = userRes['address'];
      val.phone = userRes['phone'];
      val.imageUrl = userRes['image_url'];
    });

    super.onReady();
  }
}

import 'package:get/get.dart';
import 'package:househunt/controllers/firebase_controller.dart';

class UpdateController extends GetxController {
  final int _id;
  UpdateController(this._id);

  RxBool isLoading = false.obs;

  RxList<Map<String, dynamic>> items = RxList();
  List originalItems = [];
  List deletedItems = [];
  var updated = false.obs;

  void deleteItem(item) {
    deletedItems.add(item);
    items.remove(item);
  }

  void clearAll() {
    items.clear();
    originalItems.clear();
    deletedItems.clear();
    updated.value = false;
  }

  @override
  void onReady() {
    ever(items, (val) {
      updated.value = true;
    });

    isLoading.value = true;

    if (_id != -1) {
      FireBaseController.getAssets(_id).then(
        (value) {
          items.addAll(value);
          originalItems = value;
        },
      ).catchError((err) {
        Get.snackbar(
          'Error',
          err.toString(),
        );
      }).whenComplete(
        () => isLoading.value = false,
      );
    }

    super.onReady();
  }
}

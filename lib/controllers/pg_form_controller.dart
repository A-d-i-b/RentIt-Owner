import 'dart:io';
import 'package:get/get.dart';
import 'package:househunt/controllers/firebase_controller.dart';
import 'package:househunt/controllers/text_controllers_mixin.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/http_connects/pg_connect.dart';
import 'package:househunt/models/pg_form_model.dart';

final FireBaseController fireBaseController = Get.put(FireBaseController());

class PgFormController extends GetxController
    with TextControllers, RentsTextControllers, StateMixin<List<PgFormModel>> {
  final userController = Get.find<UserController>();

  final _apiProvider = PgConnect();

  var disabledButton = false.obs;

  Rx<PgFormModel> pgFormModel = PgFormModel(
    pgName: '',
    address: '',
    description: '',
  ).obs;

  RxBool singleRoom = false.obs;
  RxBool doubleRoom = false.obs;
  RxBool tripleRoom = false.obs;
  RxBool fourRoom = false.obs;

  final roomType = <String>[].obs;

  RxList<File> assets = <File>[].obs;

  RxList pgs = [].obs;

  void updateDropdowns(flat) {
    pgFormModel.update((val) {
      val!.powerBackup = flat.powerBackup;
      val.acRooms = flat.acRooms;
      val.maintenance = flat.maintenance;
      val.electricityCharges = flat.electricityCharges;
      val.availableFor = flat.availableFor;
      val.preferredTenant = flat.preferredTenant;
      val.food = flat.food;
      val.wifi = flat.wifi;
      val.furniture = flat.furniture;
    });
  }

  void updateRoomRents(pg) {
    singleRoom.value = pg.singleRoomRent != null;
    doubleRoom.value = pg.doubleRoomRent != null;
    tripleRoom.value = pg.tripleRoomRent != null;
    fourRoom.value = pg.fourRoomRent != null;

    pgFormModel.update((val) {
      val!.singleRoomRent = pg.singleRoomRent;
      val.doubleRoomRent = pg.doubleRoomRent;
      val.tripleRoomRent = pg.tripleRoomRent;
      val.fourRoomRent = pg.fourRoomRent;
    });
  }

  @override
  void onReady() async {
    fetchPgs();

    super.onReady();
  }

  // dispose all text controllers

  void submitForm() async {
    disabledButton.value = true;
    final form = pgFormModel.value.toJson(userController.user.value.id);

    _apiProvider.postPg(userController.jwt, form).then((value) async {
      try {
        await fireBaseController.uploadFilePg(value['data']['id']);
      } catch (e) {
        print(e);
      }

      printInfo(info: 'success');
      // add a success snackbar
      Get.snackbar('Success', 'PG added successfully',
          snackPosition: SnackPosition.BOTTOM);

      clearForm();
      disabledButton.value = false;

      Get.toNamed('/home');

      clearForm();
      fetchPgs();
    }).catchError((e) {
      printError(info: 'failed');
      disabledButton.value = false;
      // add a failure snackbar
      Get.snackbar('Failed', 'Failed to add PG');
    });
  }

  void fetchPgs() async {
    _apiProvider.getPgs(userController.jwt, userController.user.value.id).then(
      (value) {
        change(value, status: RxStatus.success());
      },
    ).catchError(
      (e) {
        change(null, status: RxStatus.error(e.toString()));
      },
    );
  }

  void clearForm() {
// clear all text controllers
    clearTextControllers();

    // clear all assets
    assets.clear();

    // clear all dropdowns
    clearDropdowns();

    // clear all room rents
    clearRoomRents();
  }

  void clearTextControllers() {
    nameController.value.clear();
    addressController.value.clear();
    descriptionController.value.clear();
    roomsController.value.clear();
    singleRoomRentController.value.clear();
    doubleRoomRentController.value.clear();
    tripleRoomRentController.value.clear();
    fourRoomRentController.value.clear();
    noticePeriodController.value.clear();
    operatingSinceController.value.clear();
  }

  void clearDropdowns() {
    pgFormModel.update((val) {
      val!.powerBackup = 'N/A';
      val.acRooms = 'N/A';
      val.maintenance = 'N/A';
      val.electricityCharges = 'N/A';
      val.availableFor = 'N/A';
      val.preferredTenant = 'N/A';
      val.food = 'N/A';
      val.wifi = 'N/A';
      val.furniture = 'N/A';
    });
  }

  void clearRoomRents() {
    singleRoom.value = false;
    doubleRoom.value = false;
    tripleRoom.value = false;
    fourRoom.value = false;

    pgFormModel.update((val) {
      val!.singleRoomRent = null;
      val.doubleRoomRent = null;
      val.tripleRoomRent = null;
      val.fourRoomRent = null;
    });
  }
}

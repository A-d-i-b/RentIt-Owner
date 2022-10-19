import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:househunt/controllers/text_controllers_mixin.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/models/pg_form_model.dart';
import 'package:househunt/secrets.dart';

import 'package:househunt/utils/http_util.dart';

class PgFormController extends GetxController
    with TextControllers, RentsTextControllers {
  final userController = Get.find<UserController>();

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
    // final pgFlatRes = await getJsonFromAsset('assets/data/properties.json');

    // final pgs = pgFlatRes['pgs'];
    // this.pgs.addAll(
    //       pgs.map((e) => PgFormModel.fromJson(json: e)).toList(),
    //     );

    fetchPgs();

    super.onReady();
  }

  // dispose all text controllers

  void submitForm() async {
    disabledButton.value = true;
    final form = {
      "data": {
        "name": pgFormModel.value.pgName,
        "address": pgFormModel.value.address,
        "no_of_rooms": pgFormModel.value.noOfRooms,
        "rents": {
          "single_sharing": pgFormModel.value.singleRoomRent,
          "double_sharing": pgFormModel.value.doubleRoomRent,
          "triple_sharing": pgFormModel.value.tripleRoomRent,
          "four_sharing": pgFormModel.value.fourRoomRent,
        },
        "notice_period": pgFormModel.value.noticePeriod,
        "builtIn": pgFormModel.value.operatingSince,
        "description": pgFormModel.value.description,
        "details": {
          "power_backup": pgFormModel.value.powerBackup,
          "ac_rooms": pgFormModel.value.acRooms,
          "maintenance": pgFormModel.value.maintenance,
          "electricity_charges": pgFormModel.value.electricityCharges,
          "available_for": pgFormModel.value.availableFor,
          "preferred_tenant": pgFormModel.value.preferredTenant,
          "food": pgFormModel.value.food,
          "wifi": pgFormModel.value.wifi,
          "furniture": pgFormModel.value.furniture,
        },
        "type": "pg",
        "user": userController.user.value.id,
      }
    };

    final res =
        await postData(uri: HOUSE_URL, body: json.encode(form), headers: {
      "Authorization": "Bearer ${userController.jwt}",
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (res.statusCode == 200) {
      printInfo(info: 'success');
      // add a success snackbar
      Get.snackbar('Success', 'PG added successfully',
          snackPosition: SnackPosition.BOTTOM);

      clearForm();
      disabledButton.value = false;

      // refetch the data
      fetchPgs();

      Get.toNamed('/home');
    } else {
      printError(info: 'failed');
      // add a failure snackbar
      Get.snackbar('Failed', 'Failed to add PG');
    }
  }

  void fetchPgs() async {
    final res = await getData(uri: HOUSE_URL, headers: {
      'Authorization': 'Bearer ${userController.jwt}',
    });

    final pgsRes = [];

    for (var house in jsonDecode(res.body)['data']) {
      if (house['attributes']['type'] == 'pg') {
        pgsRes.add(house);
      }
    }

    // clear pgs list
    pgs.clear();

    pgs.addAll(
      pgsRes.map((e) => PgFormModel.fromJson(json: e)).toList(),
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

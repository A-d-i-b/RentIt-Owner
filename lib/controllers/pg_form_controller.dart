import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:househunt/controllers/text_controllers_mixin.dart';
import 'package:househunt/models/pg_form_model.dart';

import '../utils/file_utils.dart';

class PgFormController extends GetxController
    with TextControllers, RentsTextControllers {
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
    final pgFlatRes = await getJsonFromAsset('assets/data/properties.json');

    final pgs = pgFlatRes['pgs'];
    this.pgs.addAll(
          pgs.map((e) => PgFormModel.fromJson(json: e)).toList(),
        );

    super.onReady();
  }

  // dispose all text controllers

  void submitForm() async {
    final form = {
      "data": {
        "name": pgFormModel.value.pgName,
        "address": pgFormModel.value.address,
        "no_of_rooms": pgFormModel.value.noOfRooms,
        "rent": json.encode({
          "single_sharing": pgFormModel.value.singleRoomRent,
          "double_sharing": pgFormModel.value.doubleRoomRent,
          "triple_sharing": pgFormModel.value.tripleRoomRent,
          "four_sharing": pgFormModel.value.fourRoomRent,
        }),
        "notice_period": pgFormModel.value.noticePeriod,
        "builtIn": pgFormModel.value.operatingSince,
        "description": pgFormModel.value.description,
        "details": json.encode({
          "power_backup": pgFormModel.value.powerBackup,
          "ac_rooms": pgFormModel.value.acRooms,
          "maintenance": pgFormModel.value.maintenance,
          "electricity_charges": pgFormModel.value.electricityCharges,
          "available_for": pgFormModel.value.availableFor,
          "preferred_tenant": pgFormModel.value.preferredTenant,
          "food": pgFormModel.value.food,
          "wifi": pgFormModel.value.wifi,
          "furniture": pgFormModel.value.furniture,
        }),
        "type": "pg"
      }
    };

    // final res = await postData(uri: HOUSE_URL, body: json.encode(form));
  }
}

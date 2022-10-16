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
  @override
  void onClose() {
    disposeTextControllers();
    dispose();
    super.onClose();
  }
}

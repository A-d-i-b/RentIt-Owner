import 'dart:io';

import 'package:get/get.dart';
import 'package:househunt/controllers/text_controllers_mixin.dart';
import 'package:househunt/models/flat_form_model.dart';
import 'package:househunt/utils/file_utils.dart';

class FlatFormController extends GetxController with TextControllers {
  Rx<FlatFormModel> flatFormModel = FlatFormModel(
    flatName: '',
    address: '',
    description: '',
  ).obs;

  RxList<File> assets = <File>[].obs;

  RxList flats = [].obs;

  void updateDropdowns(flat) {
    flatFormModel.update((val) {
      val!.powerBackup = flat.powerBackup;
      val.acRooms = flat.acRooms;
      val.maintenance = flat.maintenance;
      val.electricityCharges = flat.electricityCharges;
      val.availableFor = flat.availableFor;
      val.preferredTenant = flat.preferredTenant;
      val.food = flat.food;
      val.wifi = flat.wifi;
      val.furniture = flat.furniture;
      val.bhk = flat.bhk;
    });
  }

  @override
  void onReady() async {
    final pgFlatRes = await getJsonFromAsset('assets/data/properties.json');

    final flats = pgFlatRes['flats'];

    this.flats.addAll(
          flats.map((e) => FlatFormModel.fromJson(json: e)).toList(),
        );

    super.onReady();
  }

  // dispose all text controllers

}

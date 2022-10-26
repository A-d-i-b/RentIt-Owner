import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/text_controllers_mixin.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/http_connects/flat_connect.dart';
import 'package:househunt/models/asset_models.dart';
import 'package:househunt/models/flat_form_model.dart';

import 'firebase_controller.dart';

class FlatFormController extends GetxController
    with TextControllers, StateMixin<List<FlatFormModel>> {
  final UserController userController = Get.find<UserController>();
  final _apiProvider = FlatConnect();

  var disabledButton = false.obs;
  late final GlobalKey<FormState> _key;
  get key => _key;
  Rx<FlatFormModel> flatFormModel = FlatFormModel(
    flatName: '',
    address: '',
    description: '',
  ).obs;

  RxList<FileAsset> assets = <FileAsset>[].obs;

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

  void deleteFlat() async {
    if (flatFormModel.value.id != null) {
      _apiProvider
          .deleteFlat(userController.jwt, flatFormModel.value.id!)
          .then((val) {
        fetchFlats();

        FireBaseController.deleteHousing(flatFormModel.value.id!);

        Get.back();
      });
    }
  }

  @override
  void onReady() async {
    _key = GlobalKey<FormState>();

    fetchFlats();
    super.onReady();
  }

  // dispose all text controllers
  void submitForm() async {
    if (!_key.currentState!.validate()) {
      return;
    }

    if (assets.isEmpty) {
      Get.snackbar(
        'Error',
        'Please add atleast one image',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final form = flatFormModel.value.toJson(userController.user.value.id);
    disabledButton.value = true;

    _apiProvider.postFlat(userController.jwt, form).then((value) async {
      try {
        await FireBaseController.uploadFileFlat(value['data']['id'], assets);
      } catch (e) {
        print(e);
      }

      printInfo(info: 'success');
      // add a success snackbar
      Get.snackbar('Success', 'Flat added successfully',
          snackPosition: SnackPosition.BOTTOM);

      clearForm();
      disabledButton.value = false;

      // refetch the data
      fetchFlats();

      // clear fields
      clearForm();

      Get.toNamed('/home');
    }).catchError((e) {
      printError(info: 'failed');
      // add a failure snackbar
      Get.snackbar('Failed', 'Failed to add Flat');
      disabledButton.value = false;
    });
  }

  void fetchFlats() async {
    _apiProvider
        .getFlats(userController.jwt, userController.user.value.id)
        .then(
      (value) {
        change(value, status: RxStatus.success());
      },
    ).catchError((error) {
      change(null, status: RxStatus.error(error.toString()));
    });
  }

  void clearForm() {
    clearTextControllers();

    // clear all assets
    assets.clear();

    // clear all dropdowns
    clearDropdowns();
  }

  void clearTextControllers() {
    nameController.value.clear();
    addressController.value.clear();
    descriptionController.value.clear();
    roomsController.value.clear();
    rentController.value.clear();
    noticePeriodController.value.clear();
    operatingSinceController.value.clear();
  }

  void clearDropdowns() {
    flatFormModel.update((val) {
      val!.powerBackup = 'N/A';
      val.acRooms = 'N/A';
      val.maintenance = 'N/A';
      val.electricityCharges = 'N/A';
      val.availableFor = 'N/A';
      val.preferredTenant = 'N/A';
      val.food = 'N/A';
      val.wifi = 'N/A';
      val.furniture = 'N/A';
      val.bhk = 'N/A';
    });
  }
}

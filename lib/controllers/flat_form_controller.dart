import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:househunt/controllers/text_controllers_mixin.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/models/flat_form_model.dart';
import 'package:househunt/secrets.dart';
import 'package:househunt/utils/http_util.dart';

class FlatFormController extends GetxController with TextControllers {
  final UserController userController = Get.find<UserController>();

  var disabledButton = false.obs;

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
    fetchFlats();
    super.onReady();
  }

  // dispose all text controllers
  void submitForm() async {
    final form = {
      "data": {
        "name": flatFormModel.value.flatName,
        "address": flatFormModel.value.address,
        "no_of_rooms": flatFormModel.value.noOfRooms,
        "rents": {
          "single_sharing": flatFormModel.value.rent,
        },
        "notice_period": flatFormModel.value.noticePeriod,
        "builtIn": flatFormModel.value.builtIn,
        "description": flatFormModel.value.description,
        "details": {
          "power_backup": flatFormModel.value.powerBackup,
          "ac_rooms": flatFormModel.value.acRooms,
          "maintenance": flatFormModel.value.maintenance,
          "electricity_charges": flatFormModel.value.electricityCharges,
          "available_for": flatFormModel.value.availableFor,
          "preferred_tenant": flatFormModel.value.preferredTenant,
          "food": flatFormModel.value.food,
          "wifi": flatFormModel.value.wifi,
          "furniture": flatFormModel.value.furniture,
          "bhk": flatFormModel.value.bhk,
        },
        "type": "flat",
        "user": userController.user.value.id,
      },
    };

    printInfo(info: form.toString());

    final res =
        await postData(uri: HOUSE_URL, body: json.encode(form), headers: {
      "Authorization": "Bearer ${userController.jwt}",
      'Content-Type': 'application/json; charset=UTF-8',
    });

    if (res.statusCode == 200) {
      printInfo(info: 'success');
      // add a success snackbar
      Get.snackbar('Success', 'Flat added successfully',
          snackPosition: SnackPosition.BOTTOM);

      clearForm();
      disabledButton.value = false;

      // refetch the data
      fetchFlats();

      Get.toNamed('/home');
    } else {
      printError(info: 'failed');
      // add a failure snackbar
      Get.snackbar('Failed', 'Failed to add Flat');
    }
  }

  void fetchFlats() async {
    final res = await getData(uri: HOUSE_URL, headers: {
      'Authorization': 'Bearer ${userController.jwt}',
    });

    final flatsRes = [];

    for (var house in jsonDecode(res.body)['data']) {
      if (house['attributes']['type'] == 'flat') {
        flatsRes.add(house);
      }
    }

    // clear pgs list
    flats.clear();

    flats.addAll(
      flatsRes.map((e) => FlatFormModel.fromJson(json: e)).toList(),
    );
  }

  void clearForm() {
// clear all text controllers
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

import 'package:get/get.dart';
import 'package:househunt/controllers/firebase_controller.dart';
import 'package:househunt/controllers/text_controllers_mixin.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/http_connects/pg_connect.dart';
import 'package:househunt/models/asset_models.dart';
import 'package:househunt/models/pg_form_model.dart';
import 'package:flutter/material.dart';
import 'package:househunt/utils/array_utils.dart';

// final FireBaseController fireBaseController = FireBaseController();

class PgFormController extends GetxController
    with TextControllers, RentsTextControllers, StateMixin<List<PgFormModel>> {
  final userController = Get.find<UserController>();
  // late final GlobalKey<FormState> _key;
  // get key => _key;
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

  RxList<FileAsset> assets = <FileAsset>[].obs;

  List<PgFormModel> pgs = [];

  void updateFlat(
      List itemsFromFirebase,
      PgFormModel old,
      List originalItemsFromFirebase,
      List deletedFirebaseImages,
      GlobalKey<FormState> key) async {
    bool imageExist = imageExists(assets, itemsFromFirebase);
    bool imageChanged =
        itemsChanged(originalItemsFromFirebase, itemsFromFirebase);

    bool flatChanged = pgFormModel.value.didChange(old);

    if (!imageExist) {
      Get.snackbar('Error', 'Add atleast one image',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (!key.currentState!.validate()) {
      return;
    }

    disabledButton.value = true;

    Future placeholderFlatForm() {
      if (flatChanged) {
        return _apiProvider.updatePg(
          userController.jwt,
          pgFormModel.value.id!,
          pgFormModel.value.toJson(
            userController.user.value.id,
          ),
        );
      } else {
        return Future.value();
      }
    }

    Future placeholderAssets() {
      if (imageChanged || assets.isNotEmpty) {
        return FireBaseController.updateAssets(
          itemsFromFirebase,
          assets,
          pgFormModel.value.id!,
          deletedFirebaseImages,
        );
      } else {
        return Future.value();
      }
    }

    try {
      await Future.wait([
        placeholderAssets(),
        placeholderFlatForm(),
      ]);

      assets.clear();
      final flatChanged =
          await _apiProvider.getPg(userController.jwt, pgFormModel.value.id!);
      // find the flat in the list and update it
      final index =
          pgs.indexWhere((element) => element.id == pgFormModel.value.id);

      pgs[index] = flatChanged;

      change(pgs, status: RxStatus.success());
      Get.back();
      Get.snackbar(
        'Success',
        'Flat Updated',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
      return;
    } finally {
      disabledButton.value = false;
    }
  }

  void deletePg() async {
    if (pgFormModel.value.id != null) {
      _apiProvider.deletePg(userController.jwt, pgFormModel.value.id!).then(
        (val) {
          FireBaseController.deleteHousing(pgFormModel.value.id!);

          fetchPgs();
          Get.back();
        },
      ).catchError(
        (err) {
          Get.snackbar('Error', err.toString());
        },
      );
    }
  }

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

  void submitForm(GlobalKey<FormState> key) async {
    if (!key.currentState!.validate()) {
      Get.snackbar('Error', 'Please fill all the fields',
          snackPosition: SnackPosition.BOTTOM);

      return;
    }

    if (!imageExists(assets, null)) {
      Get.snackbar('Error', 'Please add atleast one image',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    disabledButton.value = true;

    final form = pgFormModel.value.toJson(userController.user.value.id);

    _apiProvider.postPg(userController.jwt, form).then((value) async {
      try {
        await FireBaseController.uploadFiles(value['data']['id'], assets);
      } catch (e) {
        printError(info: e.toString());
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
        pgs = value;
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

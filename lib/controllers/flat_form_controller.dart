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

  List<FlatFormModel> flats = [];
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

  void updateFlat(
    List itemsFromFirebase,
    FlatFormModel old,
    List originalItemsFromFirebase,
    List deletedFirebaseImages,
  ) async {
    // bool imageNotExist = assets.isEmpty && itemsFromFirebase.isEmpty;
    // check atleast one type photo
    final bool imageNotExist = (() {
      for (final asset in assets) {
        if (asset.type == AssetType.photo) {
          return true;
        }
      }

      for (final item in itemsFromFirebase) {
        if (item['type'] == 'photo') {
          return true;
        }
      }

      return false;
    })();
    bool imageChanged = () {
      if (originalItemsFromFirebase.length != itemsFromFirebase.length) {
        return true;
      }
      for (int i = 0; i < itemsFromFirebase.length; i++) {
        if (originalItemsFromFirebase[i]['Url'] !=
            itemsFromFirebase[i]['Url']) {
          return true;
        }
      }
      return false;
    }();

    bool flatChanged = flatFormModel.value.didChange(old);

    if (imageNotExist) {
      Get.snackbar('Error', 'Add atleast one image',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (!_key.currentState!.validate()) {
      return;
    }

    disabledButton.value = true;

    Future placeholderFlatForm() {
      if (flatChanged) {
        return _apiProvider.updateFlat(
          userController.jwt,
          flatFormModel.value.id!,
          flatFormModel.value.toJson(
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
          flatFormModel.value.id!,
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
      final flatChanged = await _apiProvider.getFlat(
          userController.jwt, flatFormModel.value.id!);
      // find the flat in the list and update it
      final index =
          flats.indexWhere((element) => element.id == flatFormModel.value.id);

      flats[index] = flatChanged;
      change(flats, status: RxStatus.success());
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

  void deleteFlat() async {
    if (flatFormModel.value.id != null) {
      _apiProvider
          .deleteFlat(userController.jwt, flatFormModel.value.id!)
          .then((val) {
        fetchFlats();

        FireBaseController.deleteHousing(flatFormModel.value.id!).then(
          (value) => Get.back(),
        );
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
        await FireBaseController.uploadFiles(value['data']['id'], assets);
      } catch (e) {
        rethrow;
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
      printError(info: e.toString());
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
        flats = value;
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

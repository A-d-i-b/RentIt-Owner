import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin TextControllers {
  final addressController = TextEditingController().obs;
  final descriptionController = TextEditingController().obs;
  final nameController = TextEditingController().obs;
  final noticePeriodController = TextEditingController().obs;
  final operatingSinceController = TextEditingController().obs;
  final rentController = TextEditingController().obs;
  final roomsController = TextEditingController().obs;

  void updateTextFields(x, String type) {
    addressController.update((val) {
      val!.text = x.address;
    });
    descriptionController.update((val) {
      val!.text = x.description;
    });
    nameController.update((val) {
      val!.text = type == 'pg' ? x.pgName : x.flatName;
    });
    noticePeriodController.update((val) {
      val!.text = x.noticePeriod ?? '';
    });
    operatingSinceController.update((val) {
      val!.text = type == 'pg' ? x.operatingSince : x.builtIn;
    });

    rentController.update((val) {
      if (type == 'flat') val!.text = x.rent.toString();
    });
    roomsController.update((val) {
      val!.text = x.noOfRooms ?? '';
    });
  }

  void disposeTextControllers() {
    addressController.value.dispose();
    descriptionController.value.dispose();
    nameController.value.dispose();
    noticePeriodController.value.dispose();
    operatingSinceController.value.dispose();
    rentController.value.dispose();
    roomsController.value.dispose();
  }
}

mixin RentsTextControllers {
  final singleRoomRentController = TextEditingController().obs;
  final doubleRoomRentController = TextEditingController().obs;
  final tripleRoomRentController = TextEditingController().obs;
  final fourRoomRentController = TextEditingController().obs;

  void updateRentFields(x) {
    singleRoomRentController.update((val) {
      val!.text = x.singleRoomRent.toString();
    });
    doubleRoomRentController.update((val) {
      val!.text = x.doubleRoomRent.toString();
    });
    tripleRoomRentController.update((val) {
      val!.text = x.tripleRoomRent.toString();
    });
    fourRoomRentController.update((val) {
      val!.text = x.fourRoomRent.toString();
    });
  }
}

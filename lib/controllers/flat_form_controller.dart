import 'dart:io';

import 'package:get/get.dart';
import 'package:househunt/models/flat_form_model.dart';
import 'package:househunt/utils/file_utils.dart';

class FlatFormController extends GetxController {
  Rx<FlatFormModel> flatFormModel = FlatFormModel(
    flatName: '',
    address: '',
    description: '',
  ).obs;

  RxList<File> assets = <File>[].obs;

  late RxList flats;

  @override
  void onReady() async {
    final pgFlatRes = await getJsonFromAsset('assets/data/properties.json');

    final flats = pgFlatRes['flats'];

    this.flats =
        RxList(flats.map((e) => FlatFormModel.fromJson(json: e)).toList());

    super.onReady();
  }
}

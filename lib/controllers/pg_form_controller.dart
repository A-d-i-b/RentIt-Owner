import 'dart:io';

import 'package:get/get.dart';
import 'package:househunt/models/pg_form_model.dart';

import '../utils/file_utils.dart';

class PgFormController extends GetxController {
  Rx<PgFormModel> pgFormModel = PgFormModel(
    pgName: '',
    address: '',
    description: '',
  ).obs;

  final roomType = <String>[].obs;

  RxList<File> assets = <File>[].obs;

  late RxList<PgFormModel> pgs;

  @override
  void onReady() async {
    final pgFlatRes = await getJsonFromAsset('assets/data/properties.json');

    final pgs = pgFlatRes['pgs'];
    this.pgs = RxList(pgs.map((e) => PgFormModel.fromJson(json: e)).toList());

    super.onReady();
  }
}

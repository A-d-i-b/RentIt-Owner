import 'package:get/get.dart';
import 'package:househunt/models/pg_form_model.dart';

class PgFormController extends GetxController {
  Rx<PgFormModel> pgFormModel = PgFormModel(
    pgName: '',
    address: '',
    description: '',
  ).obs;

  final roomType = <String>[].obs;
}

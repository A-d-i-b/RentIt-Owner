import 'package:househunt/models/flat_form_model.dart';
import 'package:househunt/secrets.dart';
import 'package:get/get.dart';

import '../controllers/pg_form_controller.dart';

class FlatConnect extends GetConnect {
  final PgFormController pgFormController = Get.put(PgFormController());
  Future<List<FlatFormModel>> getFlats(String jwt, int id) async {
    final response = await get("$USER_URL/$id?populate=housing", headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $jwt',
    });

    if (response.isOk) {
      final List<FlatFormModel> flats = [];
      for (var house in response.body['housing']) {
        if (house['type'] == 'flat') {
          flats.add(FlatFormModel.fromJson(json: house));
        }
      }
      return flats;
    } else {
      throw Exception('Failed to load flats');
    }
  }

  Future postFlat(String jwt, Map data) async {
    final response = await post(
      HOUSE_URL,
      data,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );
    if (response.isOk) {
      return response.body;
    } else {
      throw Exception('Failed to post flat');
    }
  }
}

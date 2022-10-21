import 'package:get/get_connect.dart';
import 'package:househunt/models/pg_form_model.dart';
import 'package:househunt/secrets.dart';

class PgConnect extends GetConnect {
  Future<List<PgFormModel>> getPgs(String jwt) async {
    final response = await get(HOUSE_URL, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $jwt',
    });

    if (response.statusCode == 200) {
      final List<PgFormModel> pgs = [];
      for (var house in response.body['data']) {
        if (house['attributes']['type'] == 'pg') {
          pgs.add(PgFormModel.fromJson(json: house));
        }
      }
      return pgs;
    } else {
      throw Exception('Failed to load pgs');
    }
  }
}

import 'package:get/get_connect.dart';
import 'package:househunt/models/flat_form_model.dart';
import 'package:househunt/secrets.dart';

class FlatConnect extends GetConnect {
  Future<List<FlatFormModel>> getFlats(String jwt) async {
    final response = await get(HOUSE_URL, headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $jwt',
    });

    if (response.statusCode == 200) {
      final List<FlatFormModel> flats = [];
      for (var house in response.body['data']) {
        if (house['attributes']['type'] == 'flat') {
          flats.add(FlatFormModel.fromJson(json: house));
        }
      }
      return flats;
    } else {
      throw Exception('Failed to load pgs');
    }
  }
}

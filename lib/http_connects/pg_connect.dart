import 'package:get/get_connect.dart';
import 'package:househunt/models/pg_form_model.dart';
import 'package:househunt/secrets.dart';

class PgConnect extends GetConnect {
  Future<List<PgFormModel>> getPgs(String jwt, int id) async {
    final response = await get("$USER_URL/$id?populate=housing", headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $jwt',
    });

    if (response.statusCode == 200) {
      final List<PgFormModel> pgs = [];
      for (var house in response.body['housing']) {
        if (house['type'] == 'pg') {
          pgs.add(PgFormModel.fromJson(json: house));
        }
      }
      return pgs;
    } else {
      throw Exception('Failed to load pgs');
    }
  }

  Future postPg(String jwt, Map data) async {
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
      throw Exception('Failed to post pg');
    }
  }

  Future deletePg(String jwt, int id) async {
    final response = await delete(
      '$HOUSE_URL/$id',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );
    if (response.isOk) {
      return response.body;
    } else {
      throw Exception('Failed to delete pg');
    }
  }

  Future getPg(String jwt, int id) async {
    final response = await get(
      '$HOUSE_URL/$id',
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $jwt',
      },
    );
    if (response.isOk) {
      final json = response.body['data']['attributes'];
      json['id'] = response.body['data']['id'];

      return PgFormModel.fromJson(json: json);
    } else {
      throw Exception('Failed to get pg');
    }
  }

  Future updatePg(String jwt, int id, Map data) async {
    final response = await put(
      '$HOUSE_URL/$id',
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
      throw Exception('Failed to update pg');
    }
  }
}

import 'package:househunt/models/mixins.dart';

class PgFormModel
    with
        PowerBackup,
        AcRooms,
        Maintenance,
        ElectricityCharges,
        AvailableFor,
        PreferredTenants,
        Food,
        Furniture,
        Wifi {
  int? id;
  String pgName = '';
  String address;
  String? noOfRooms;

  String? singleRoomRent;
  String? doubleRoomRent;
  String? tripleRoomRent;
  String? fourRoomRent;

  String powerBackup;
  String acRooms;
  String maintenance;
  String electricityCharges;
  String availableFor;
  String preferredTenant;
  String food;
  String wifi;
  String furniture;

  String? noticePeriod;
  String? operatingSince;
  String description;

  PgFormModel({
    this.id,
    required this.pgName,
    required this.address,
    this.noOfRooms,
    this.singleRoomRent,
    this.doubleRoomRent,
    this.tripleRoomRent,
    this.fourRoomRent,
    this.powerBackup = 'N/A',
    this.acRooms = 'N/A',
    this.maintenance = 'N/A',
    this.electricityCharges = 'N/A',
    this.availableFor = 'N/A',
    this.preferredTenant = 'N/A',
    this.food = 'N/A',
    this.wifi = 'N/A',
    this.furniture = 'N/A',
    this.noticePeriod,
    this.operatingSince,
    required this.description,
  });

  factory PgFormModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return PgFormModel(
      id: json['id'],
      pgName: json['attributes']['name'],
      address: json['attributes']['address'],
      noOfRooms: json['attributes']['no_of_rooms'].toString(),
      singleRoomRent:
          (json['attributes']["rents"]["single_sharing"])?.toString(),
      doubleRoomRent:
          (json['attributes']["rents"]["double_sharing"])?.toString(),
      tripleRoomRent:
          (json['attributes']["rents"]["triple_sharing"])?.toString(),
      fourRoomRent: (json['attributes']["rents"]["four_sharing"])?.toString(),
      powerBackup: json['attributes']['details']['power_backup'],
      acRooms: json['attributes']['details']['ac_rooms'],
      maintenance: json['attributes']['details']['maintenance'],
      electricityCharges: json['attributes']['details']['electricity_charges'],
      availableFor: json['attributes']['details']['available_for'],
      preferredTenant: json['attributes']['details']['preferred_tenant'],
      food: json['attributes']['details']['food'],
      wifi: json['attributes']['details']['wifi'],
      furniture: json['attributes']['details']['furniture'],
      noticePeriod: json['attributes']['notice_period'],
      operatingSince: json['attributes']['builtIn'],
      description: json['attributes']['description'],
    );
  }
//TODO: remove toString() from all the fields

  toJson(int id) {
    return {
      "data": {
        "name": pgName,
        "address": address,
        "no_of_rooms": noOfRooms,
        "rents": {
          "single_sharing": singleRoomRent,
          "double_sharing": doubleRoomRent,
          "triple_sharing": tripleRoomRent,
          "four_sharing": fourRoomRent,
        },
        "notice_period": noticePeriod,
        "builtIn": operatingSince,
        "description": description,
        "details": {
          "power_backup": powerBackup,
          "ac_rooms": acRooms,
          "maintenance": maintenance,
          "electricity_charges": electricityCharges,
          "available_for": availableFor,
          "preferred_tenant": preferredTenant,
          "food": food,
          "wifi": wifi,
          "furniture": furniture,
        },
        "type": "pg",
        "user": id,
      }
    };
  }
}

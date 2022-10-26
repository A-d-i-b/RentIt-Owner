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
      pgName: json['name'],
      address: json['address'],
      noOfRooms: json['no_of_rooms'],
      singleRoomRent: (json["rents"]["single_sharing"]),
      doubleRoomRent: (json["rents"]["double_sharing"]),
      tripleRoomRent: (json["rents"]["triple_sharing"]),
      fourRoomRent: (json["rents"]["four_sharing"]),
      powerBackup: json['details']['power_backup'],
      acRooms: json['details']['ac_rooms'],
      maintenance: json['details']['maintenance'],
      electricityCharges: json['details']['electricity_charges'],
      availableFor: json['details']['available_for'],
      preferredTenant: json['details']['preferred_tenant'],
      food: json['details']['food'],
      wifi: json['details']['wifi'],
      furniture: json['details']['furniture'],
      noticePeriod: json['notice_period'],
      operatingSince: json['builtIn'],
      description: json['description'],
    );
  }

  factory PgFormModel.from(PgFormModel model) {
    return PgFormModel(
      id: model.id,
      pgName: model.pgName,
      address: model.address,
      noOfRooms: model.noOfRooms,
      singleRoomRent: model.singleRoomRent,
      doubleRoomRent: model.doubleRoomRent,
      tripleRoomRent: model.tripleRoomRent,
      fourRoomRent: model.fourRoomRent,
      powerBackup: model.powerBackup,
      acRooms: model.acRooms,
      maintenance: model.maintenance,
      electricityCharges: model.electricityCharges,
      availableFor: model.availableFor,
      preferredTenant: model.preferredTenant,
      food: model.food,
      wifi: model.wifi,
      furniture: model.furniture,
      noticePeriod: model.noticePeriod,
      operatingSince: model.operatingSince,
      description: model.description,
    );
  }

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

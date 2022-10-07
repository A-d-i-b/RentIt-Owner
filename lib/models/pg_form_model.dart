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
  int? noOfRooms;

  double? singleRoomRent;
  double? doubleRoomRent;
  double? tripleRoomRent;
  double? fourRoomRent;

  String powerBackup;
  String acRooms;
  String maintenance;
  String electricityCharges;
  String availableFor;
  String preferredTenant;
  String food;
  String wifi;
  String furniture;

  int? noticePeriod;
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
      singleRoomRent: (json["rents"]["single_sharing"])?.toDouble(),
      doubleRoomRent: (json["rents"]["double_sharing"])?.toDouble(),
      tripleRoomRent: (json["rents"]["triple_sharing"])?.toDouble(),
      fourRoomRent: (json["rents"]["four_sharing"])?.toDouble(),
      powerBackup: json['details']['power_backup'],
      acRooms: json['details']['ac_rooms'],
      maintenance: json['details']['maintenance'],
      electricityCharges: json['details']['electricity_charges'],
      availableFor: json['details']['available_for'],
      preferredTenant: json['details']['preferred_tenants'],
      food: json['details']['food'],
      wifi: json['details']['wifi'],
      furniture: json['details']['furniture'],
      noticePeriod: json['noticePeriod'],
      operatingSince: json['builtIn'].toString(),
      description: json['description'],
    );
  }
}

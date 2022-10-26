import 'package:househunt/models/mixins.dart';

class FlatFormModel
    with
        PowerBackup,
        AcRooms,
        Maintenance,
        ElectricityCharges,
        AvailableFor,
        PreferredTenants,
        Food,
        Wifi,
        Furniture,
        BHK {
  int? id;

  String flatName = '';
  String address;
  String? noOfRooms;

  String? rent;

  String powerBackup;
  String acRooms;
  String maintenance;
  String electricityCharges;
  String availableFor;
  String preferredTenant;
  String food;
  String wifi;
  String furniture;
  String bhk;

  String? noticePeriod;
  String? builtIn;
  String description;

  FlatFormModel({
    this.id,
    required this.flatName,
    required this.address,
    this.noOfRooms,
    this.rent,
    this.powerBackup = 'N/A',
    this.acRooms = 'N/A',
    this.maintenance = 'N/A',
    this.electricityCharges = 'N/A',
    this.availableFor = 'N/A',
    this.preferredTenant = 'N/A',
    this.food = 'N/A',
    this.wifi = 'N/A',
    this.furniture = 'N/A',
    this.bhk = 'N/A',
    this.noticePeriod,
    this.builtIn,
    required this.description,
  });

  void changeFieldsFromExistingFlat(FlatFormModel flat) {
    flatName = flat.flatName;
    address = flat.address;
    noOfRooms = flat.noOfRooms;
    rent = flat.rent;
    powerBackup = flat.powerBackup;
    acRooms = flat.acRooms;
    maintenance = flat.maintenance;
    electricityCharges = flat.electricityCharges;
    availableFor = flat.availableFor;
    preferredTenant = flat.preferredTenant;
    food = flat.food;
    wifi = flat.wifi;
    furniture = flat.furniture;
    bhk = flat.bhk;
    noticePeriod = flat.noticePeriod;
    builtIn = flat.builtIn;
    description = flat.description;
  }

  //TODO: remove toString() from all the fields

  factory FlatFormModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return FlatFormModel(
      id: json['id'],
      flatName: json['name'],
      address: json['address'],
      noOfRooms: json['no_of_rooms'],
      rent: json['rents']['single_sharing'],
      powerBackup: json['details']['power_backup'],
      acRooms: json['details']['ac_rooms'],
      maintenance: json['details']['maintenance'],
      electricityCharges: json['details']['electricity_charges'],
      availableFor: json['details']['available_for'],
      preferredTenant: json['details']['preferred_tenant'],
      food: json['details']['food'],
      wifi: json['details']['wifi'],
      bhk: json['details']['bhk'],
      furniture: json['details']['furniture'],
      noticePeriod: json['notice_period'].toString(),
      builtIn: json['builtIn'].toString(),
      description: json['description'],
    );
  }

  factory FlatFormModel.from(FlatFormModel model) {
    return FlatFormModel(
      id: model.id,
      flatName: model.flatName,
      address: model.address,
      noOfRooms: model.noOfRooms,
      rent: model.rent,
      powerBackup: model.powerBackup,
      acRooms: model.acRooms,
      maintenance: model.maintenance,
      electricityCharges: model.electricityCharges,
      availableFor: model.availableFor,
      preferredTenant: model.preferredTenant,
      food: model.food,
      wifi: model.wifi,
      bhk: model.bhk,
      furniture: model.furniture,
      noticePeriod: model.noticePeriod,
      builtIn: model.builtIn,
      description: model.description,
    );
  }

  toJson(int id) {
    return {
      "data": {
        "name": flatName,
        "address": address,
        "no_of_rooms": noOfRooms,
        "rents": {
          "single_sharing": rent,
        },
        "notice_period": noticePeriod,
        "builtIn": builtIn,
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
          "bhk": bhk,
        },
        "type": "flat",
        "user": id,
      },
    };
  }
}

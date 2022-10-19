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
      flatName: json['attributes']['name'],
      address: json['attributes']['address'],
      noOfRooms: json['attributes']['no_of_rooms'],
      rent: json['attributes']['rents']['single_sharing'],
      powerBackup: json['attributes']['details']['power_backup'],
      acRooms: json['attributes']['details']['ac_rooms'],
      maintenance: json['attributes']['details']['maintenance'],
      electricityCharges: json['attributes']['details']['electricity_charges'],
      availableFor: json['attributes']['details']['available_for'],
      preferredTenant: json['attributes']['details']['preferred_tenant'],
      food: json['attributes']['details']['food'],
      wifi: json['attributes']['details']['wifi'],
      bhk: json['attributes']['details']['bhk'],
      furniture: json['attributes']['details']['furniture'],
      noticePeriod: json['attributes']['notice_period'].toString(),
      builtIn: json['attributes']['builtIn'].toString(),
      description: json['attributes']['description'],
    );
  }

  toJson() {
    return {
      'flatName': flatName,
      'address': address,
      'noOfRooms': noOfRooms,
      'rent': rent,
      'powerBackup': powerBackup,
      'acRooms': acRooms,
      'maintenance': maintenance,
      'electricityCharges': electricityCharges,
      'availableFor': availableFor,
      'preferredTenant': preferredTenant,
      'food': food,
      'wifi': wifi,
      'furniture': furniture,
      'bhk': bhk,
      'noticePeriod': noticePeriod,
      'builtIn': builtIn,
      'description': description,
    };
  }
}

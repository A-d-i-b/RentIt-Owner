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

  factory FlatFormModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return FlatFormModel(
      id: json['id'],
      flatName: json['name'],
      address: json['address'],
      noOfRooms: json['no_of_rooms'].toString(),
      rent: json['rent'].toString(),
      powerBackup: json['details']['power_backup'],
      acRooms: json['details']['ac_rooms'],
      maintenance: json['details']['maintenance'],
      electricityCharges: json['details']['electricity_charges'],
      availableFor: json['details']['available_for'],
      preferredTenant: json['details']['preferred_tenants'],
      food: json['details']['food'],
      wifi: json['details']['wifi'],
      bhk: json['details']['bhk'],
      furniture: json['details']['furniture'],
      noticePeriod: json['notice_period'].toString(),
      builtIn: json['builtIn'].toString(),
      description: json['description'],
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

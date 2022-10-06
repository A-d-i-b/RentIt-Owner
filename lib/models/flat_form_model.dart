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

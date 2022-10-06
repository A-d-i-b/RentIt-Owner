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
}

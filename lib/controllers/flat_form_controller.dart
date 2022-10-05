import 'package:get/get.dart';

class FlatFormController extends GetxController {
  RxMap<String, String> extra_details = {
    "Address": "",
    "No. of Rooms": "",
    "Rent": "",
    "Notice Period": "",
    "Description": "",
  }.obs;

  RxMap<String, String> details = {
    "Power Backup": "N/A", //index 0
    "AC Rooms": "N/A", //index 1
    "Maintenance": "N/A", //index 2
    "Electricity Charges": "N/A", //index 3
    "Available for": "N/A", // index 4
    "Preferred Tenants": "N/A", // index 5
    "Food": "N/A", // index 6
    "Wifi": "N/A", // index 7
    "Furniture": "N/A",
    "BHK": "N/A", // else
  }.obs;

  changeExtraDetails(String key, String value) {
    extra_details[key] = value;
  }

  changeDetails(String key, String value) {
    details[key] = value;
  }
}

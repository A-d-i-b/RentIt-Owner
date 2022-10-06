import 'package:get/get.dart';
import 'package:househunt/models/flat_form_model.dart';

class FlatFormController extends GetxController
// with
//     PowerBackup,
//     AcRooms,
//     Maintenance,
//     ElectricityCharges,
//     AvailableFor,
//     PreferredTenants,
//     Food,
//     Wifi,
//     Furniture,
//     BHK
{
  Rx<FlatFormModel> flatFormModel = FlatFormModel(
    flatName: '',
    address: '',
    description: '',
  ).obs;

  // String flatName = '';
  // String address = '';
  // String? noOfRooms;

  // String? rent;

  // RxString powerBackup = 'N/A'.obs;
  // RxString acRooms = 'N/A'.obs;
  // RxString maintenance = 'N/A'.obs;
  // RxString electricityCharges = 'N/A'.obs;
  // RxString availableFor = 'N/A'.obs;
  // RxString preferredTenant = 'N/A'.obs;
  // RxString food = 'N/A'.obs;
  // RxString wifi = 'N/A'.obs;
  // RxString furniture = 'N/A'.obs;
  // RxString bhk = 'N/A'.obs;

  // String? noticePeriod;
  // String? builtIn;
  // String description = '';

  // updatePowerBackup(String newPowerBackup) {
  //   flatFormModel.update((val) {
  //     val!.powerBackup = newPowerBackup;
  //   });
  //   update();
  // }
}

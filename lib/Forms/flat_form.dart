import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/flat_form_controller.dart';
import 'package:househunt/utils/dropdown_util.dart';
import 'package:househunt/widgets/dropdown_button.dart';
import 'package:househunt/widgets/input_field.dart';

class FlatForm extends StatefulWidget {
  const FlatForm({Key? key}) : super(key: key);

  @override
  State<FlatForm> createState() => _FlatFormState();
}

class _FlatFormState extends State<FlatForm> {
  FlatFormController flatFormController = Get.put(FlatFormController());

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 20,
          ),
          //
          Field(
            heading: 'Address',
            maxLines: 5,
            hint: 'Address',
            keyboardType: TextInputType.text,
            onChange: (value) {
              flatFormController.flatFormModel.value.address = value;
            },
          ),
          const SizedBox(
            height: 5,
          ),

          Field(
            heading: 'No. of Rooms',
            hint: 'Rooms',
            keyboardType: TextInputType.number,
            onChange: (String value) {
              flatFormController.flatFormModel.value.noOfRooms = value;
            },
          ),

          const SizedBox(height: 5),

          Field(
            heading: "Rent",
            hint: "Amount",
            keyboardType: TextInputType.number,
            onChange: (value) {
              flatFormController.flatFormModel.value.rent = value;
            },
          ),

          const SizedBox(
            height: 30,
          ),

          const Text(
            "Flat Details",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Obx(
                () => DropDownButton(
                  name: "Power Backup",
                  items: generateItems(flatFormController
                      .flatFormModel.value.powerBackUpOptions),
                  onChange: (value) {
                    flatFormController.flatFormModel.update((val) {
                      val!.powerBackup = value;
                    });
                  },
                  value: flatFormController.flatFormModel.value.powerBackup,
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "AC Rooms",
                  items: generateItems(
                      flatFormController.flatFormModel.value.acRoomsOptions),
                  onChange: (value) {
                    flatFormController.flatFormModel.update((val) {
                      val!.acRooms = value;
                    });
                  },
                  value: flatFormController.flatFormModel.value.acRooms,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Obx(
                () => DropDownButton(
                  name: "Maintenance",
                  items: generateItems(flatFormController
                      .flatFormModel.value.maintenanceOptions),
                  onChange: (value) {
                    flatFormController.flatFormModel.update((val) {
                      val!.maintenance = value;
                    });
                  },
                  value: flatFormController.flatFormModel.value.maintenance,
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "Electricity Charges",
                  items: generateItems(flatFormController
                      .flatFormModel.value.electricityOptions),
                  onChange: (value) {
                    flatFormController.flatFormModel.update((val) {
                      val!.electricityCharges = value;
                    });
                  },
                  value:
                      flatFormController.flatFormModel.value.electricityCharges,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Obx(
                () => DropDownButton(
                  name: "Available for",
                  items: generateItems(flatFormController
                      .flatFormModel.value.availableForOptions),
                  onChange: (value) {
                    flatFormController.flatFormModel.update((val) {
                      val!.availableFor = value;
                    });
                  },
                  value: flatFormController.flatFormModel.value.availableFor,
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "Preferred Tenants",
                  items: generateItems(flatFormController
                      .flatFormModel.value.preferredTenantOptions),
                  onChange: (value) {
                    flatFormController.flatFormModel.update((val) {
                      val!.preferredTenant = value;
                    });
                  },
                  value: flatFormController.flatFormModel.value.preferredTenant,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Obx(
                () => DropDownButton(
                  name: "Food",
                  items: generateItems(
                      flatFormController.flatFormModel.value.foodOptions),
                  onChange: (value) {
                    flatFormController.flatFormModel.update((val) {
                      val!.food = value;
                    });
                  },
                  value: flatFormController.flatFormModel.value.food,
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "Wifi",
                  items: generateItems(
                      flatFormController.flatFormModel.value.wifiOptions),
                  onChange: (value) {
                    flatFormController.flatFormModel.update((val) {
                      val!.wifi = value;
                    });
                  },
                  value: flatFormController.flatFormModel.value.wifi,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Obx(
                () => DropDownButton(
                  name: "Furniture",
                  items: generateItems(
                      flatFormController.flatFormModel.value.furnitureOptions),
                  onChange: (value) {
                    flatFormController.flatFormModel.update((val) {
                      val!.furniture = value;
                    });
                  },
                  value: flatFormController.flatFormModel.value.furniture,
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "BHK",
                  items: generateItems(
                      flatFormController.flatFormModel.value.bhkOptions),
                  onChange: (value) {
                    flatFormController.flatFormModel.update((val) {
                      val!.bhk = value;
                    });
                  },
                  value: flatFormController.flatFormModel.value.bhk,
                ),
              ),
            ],
          ),
          const SizedBox(height: 30),
          Field(
            heading: "Notice Period",
            hint: "Month",
            keyboardType: TextInputType.text,
            onChange: (value) {
              flatFormController.flatFormModel.value.noticePeriod = value;
            },
          ),
          const SizedBox(height: 15),
          Field(
            heading: "Built In",
            hint: "Year",
            keyboardType: TextInputType.number,
            onChange: (value) {
              flatFormController.flatFormModel.value.builtIn = value;
            },
          ),
          const SizedBox(height: 15),
          Field(
            heading: "Description",
            hint: "Short Description",
            keyboardType: TextInputType.text,
            maxLines: 5,
            onChange: (value) {
              flatFormController.flatFormModel.value.description = value;
            },
          ),
          const SizedBox(height: 15),
          Center(
            child: ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
                print(flatFormController.flatFormModel.value.toJson());
              },
              child: SizedBox(
                width: Get.width / 3.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Center(
                    child: Text(
                      "Submit",
                      style: Get.textTheme.headline5!.copyWith(
                          color: Colors.white, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

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

  final items0 = generateItems(["N/A", "Students"]);
  final items1 = generateItems(["N/A", "Available", "Not Available"]);
  final items2 = generateItems(["N/A", "Included", "Not Included"]);
  final items3 = generateItems(["N/A", "Male", "Female", "Both"]);
  final items4 =
      generateItems(["N/A", "Furnished", "Semi Furnished", "Not Furnished"]);
  final items5 = ((int maxBhk) {
    List<DropdownMenuItem<String>> temp = [
      const DropdownMenuItem(
        value: "N/A",
        child: Center(child: Text("N/A")),
      ),
    ];
    for (int i = 1; i <= maxBhk; i++) {
      temp.add(
        DropdownMenuItem(
          value: "$i",
          child: Center(child: Text("$i")),
        ),
      );
    }
    return temp;
  })(4);

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
              flatFormController.changeExtraDetails("Address", value);
            },
          ),
          const SizedBox(
            height: 5,
          ),

          Field(
            heading: 'No. of Rooms',
            hint: 'Rooms',
            keyboardType: TextInputType.number,
            onChange: (value) {
              flatFormController.changeExtraDetails("No. of Rooms", value);
            },
          ),

          const SizedBox(height: 5),

          Field(
            heading: "Rent",
            hint: "Amount",
            keyboardType: TextInputType.number,
            onChange: (value) {
              flatFormController.changeExtraDetails("Rent", value);
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
                  items: items1,
                  onChange: (value) {
                    flatFormController.changeDetails("Power Backup", value);
                  },
                  value: flatFormController.details["Power Backup"] ?? "N/A",
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "AC Rooms",
                  items: items1,
                  onChange: (value) {
                    flatFormController.changeDetails("AC Rooms", value);
                  },
                  value: flatFormController.details["AC Rooms"] ?? "N/A",
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
                  items: items2,
                  onChange: (value) {
                    flatFormController.changeDetails("Maintenance", value);
                  },
                  value: flatFormController.details["Maintenance"] ?? "N/A",
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "Electricity Charges",
                  items: items2,
                  onChange: (value) {
                    flatFormController.changeDetails(
                        "Electricity Charges", value);
                  },
                  value: flatFormController.details["Electricity Charges"] ??
                      "N/A",
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
                  items: items3,
                  onChange: (value) {
                    flatFormController.changeDetails("Available for", value);
                  },
                  value: flatFormController.details["Available for"] ?? "N/A",
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "Preferred Tenants",
                  items: items0,
                  onChange: (value) {
                    flatFormController.changeDetails(
                        "Preferred Tenants", value);
                  },
                  value:
                      flatFormController.details["Preferred Tenants"] ?? "N/A",
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
                  items: items1,
                  onChange: (value) {
                    flatFormController.changeDetails("Food", value);
                  },
                  value: flatFormController.details["Food"] ?? "N/A",
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "Wifi",
                  items: items1,
                  onChange: (value) {
                    flatFormController.changeDetails("Wifi", value);
                  },
                  value: flatFormController.details["Wifi"] ?? "N/A",
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
                  items: items4,
                  onChange: (value) {
                    flatFormController.changeDetails("Furniture", value);
                  },
                  value: flatFormController.details["Furniture"] ?? "N/A",
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "BHK",
                  items: items5,
                  onChange: (value) {
                    flatFormController.changeDetails("BHK", value);
                  },
                  value: flatFormController.details["BHK"] ?? "N/A",
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
              flatFormController.changeExtraDetails("Notice Period", value);
            },
          ),
          const SizedBox(height: 15),
          Field(
            heading: "Built In",
            hint: "Year",
            keyboardType: TextInputType.number,
            onChange: (value) {
              flatFormController.changeExtraDetails("Built In", value);
            },
          ),
          const SizedBox(height: 15),
          Field(
            heading: "Description",
            hint: "Short Description",
            keyboardType: TextInputType.text,
            maxLines: 5,
            onChange: (value) {
              flatFormController.changeExtraDetails("Description", value);
            },
          ),
          const SizedBox(height: 15),
          Center(
            child: ElevatedButton(
              onPressed: () {
                FocusManager.instance.primaryFocus?.unfocus();
              },
              child: SizedBox(
                width: Get.width / 2.5,
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

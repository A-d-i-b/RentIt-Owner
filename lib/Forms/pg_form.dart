import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/pg_form_controller.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:househunt/utils/dropdown_util.dart';
import 'package:househunt/widgets/custom_button.dart';
import 'package:househunt/widgets/dropdown_button.dart';
import 'package:househunt/widgets/input_field.dart';

class PgForm extends StatefulWidget {
  const PgForm({Key? key}) : super(key: key);

  @override
  State<PgForm> createState() => _PgFormState();
}

class _PgFormState extends State<PgForm> {
  // insert controller
  PgFormController pgFormController = Get.put(PgFormController());

  int single = 0;
  int double = 0;
  int triple = 0;
  int quadruple = 0;

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
              pgFormController.pgFormModel.value.address = value;
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
              pgFormController.pgFormModel.value.noOfRooms = value;
            },
          ),
          const SizedBox(
            height: 30,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Type",
                style: TextStyle(fontSize: 20),
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (single == 0) {
                          pgFormController.roomType.add("Single");
                        }
                        if (single == 1) {
                          if (pgFormController.roomType.isNotEmpty) {
                            pgFormController.roomType.remove("Single");
                          }
                        }
                        setState(() {
                          single == 0 ? single = 1 : single = 0;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          single == 0 ? Colors.white : primary,
                        ),
                      ),
                      child: const Text(
                        "Single",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (double == 0) {
                          pgFormController.roomType.add("Double");
                        }
                        if (double == 1) {
                          if (pgFormController.roomType.isNotEmpty) {
                            pgFormController.roomType.remove("Double");
                          }
                        }
                        setState(() {
                          double == 0 ? double = 1 : double = 0;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          double == 0 ? Colors.white : primary,
                        ),
                      ),
                      child: const Text(
                        "Double",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (triple == 0) {
                          pgFormController.roomType.add("Triple");
                        }
                        if (triple == 1) {
                          if (pgFormController.roomType.isNotEmpty) {
                            pgFormController.roomType.remove("Triple");
                          }
                        }
                        setState(() {
                          triple == 0 ? triple = 1 : triple = 0;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          triple == 0 ? Colors.white : primary,
                        ),
                      ),
                      child: const Text(
                        "Triple",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 50,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (quadruple == 0) {
                          pgFormController.roomType.add("Quadruple");
                        }
                        if (quadruple == 1) {
                          if (pgFormController.roomType.isNotEmpty) {
                            pgFormController.roomType.remove("Quadruple");
                          }
                        }
                        setState(() {
                          quadruple == 0 ? quadruple = 1 : quadruple = 0;
                        });
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(
                          quadruple == 0 ? Colors.white : primary,
                        ),
                      ),
                      child: const Text(
                        "Quadruple",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Rent",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 15),
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1, color: primary),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    if (single == 0 &&
                        double == 0 &&
                        triple == 0 &&
                        quadruple == 0)
                      const Center(
                        child: Text("Choose appropriate type"),
                      ),
                    if (single == 1) ...[
                      CustomButton(
                          type: "Single",
                          onPressed: (value) {
                            pgFormController.pgFormModel.value.singleRoomRent =
                                value;
                          }),
                      const SizedBox(height: 7),
                    ],
                    if (double == 1) ...[
                      CustomButton(
                          type: "Double",
                          onPressed: (value) {
                            pgFormController.pgFormModel.value.doubleRoomRent =
                                value;
                          }),
                      const SizedBox(height: 7),
                    ],
                    if (triple == 1) ...[
                      CustomButton(
                          type: "Triple",
                          onPressed: (value) {
                            pgFormController.pgFormModel.value.tripleRoomRent =
                                value;
                          }),
                      const SizedBox(height: 7),
                    ],
                    if (quadruple == 1) ...[
                      CustomButton(
                          type: "Quadruple",
                          onPressed: (value) {
                            pgFormController.pgFormModel.value.fourRoomRent =
                                value;
                          }),
                      const SizedBox(height: 7),
                    ],
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            "PG Details",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Obx(
                () => DropDownButton(
                  name: "Power Backup",
                  items: generateItems(
                      pgFormController.pgFormModel.value.powerBackUpOptions),
                  onChange: (value) {
                    pgFormController.pgFormModel.update((val) {
                      val!.powerBackup = value;
                    });
                  },
                  value: pgFormController.pgFormModel.value.powerBackup,
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "AC Rooms",
                  items: generateItems(
                      pgFormController.pgFormModel.value.acRoomsOptions),
                  onChange: (value) {
                    pgFormController.pgFormModel.update((val) {
                      val!.acRooms = value;
                    });
                  },
                  value: pgFormController.pgFormModel.value.acRooms,
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
                  items: generateItems(
                      pgFormController.pgFormModel.value.maintenanceOptions),
                  onChange: (value) {
                    pgFormController.pgFormModel.update((val) {
                      val!.maintenance = value;
                    });
                  },
                  value: pgFormController.pgFormModel.value.maintenance,
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "Electricity Charges",
                  items: generateItems(
                      pgFormController.pgFormModel.value.electricityOptions),
                  onChange: (value) {
                    pgFormController.pgFormModel.update((val) {
                      val!.electricityCharges = value;
                    });
                  },
                  value: pgFormController.pgFormModel.value.electricityCharges,
                ),
              )
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Obx(
                () => DropDownButton(
                  name: "Available for",
                  items: generateItems(
                      pgFormController.pgFormModel.value.availableForOptions),
                  onChange: (value) {
                    pgFormController.pgFormModel.update((val) {
                      val!.availableFor = value;
                    });
                  },
                  value: pgFormController.pgFormModel.value.availableFor,
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "Preferred Tenants",
                  items: generateItems(pgFormController
                      .pgFormModel.value.preferredTenantOptions),
                  onChange: (value) {
                    pgFormController.pgFormModel.update((val) {
                      val!.preferredTenant = value;
                    });
                  },
                  value: pgFormController.pgFormModel.value.preferredTenant,
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
                      pgFormController.pgFormModel.value.foodOptions),
                  onChange: (value) {
                    pgFormController.pgFormModel.update((val) {
                      val!.food = value;
                    });
                  },
                  value: pgFormController.pgFormModel.value.food,
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "Wifi",
                  items: generateItems(
                      pgFormController.pgFormModel.value.wifiOptions),
                  onChange: (value) {
                    pgFormController.pgFormModel.update((val) {
                      val!.wifi = value;
                    });
                  },
                  value: pgFormController.pgFormModel.value.wifi,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "Furniture",
                  items: generateItems(
                      pgFormController.pgFormModel.value.furnitureOptions),
                  onChange: (value) {
                    pgFormController.pgFormModel.update((val) {
                      val!.furniture = value;
                    });
                  },
                  value: pgFormController.pgFormModel.value.furniture,
                ),
              ),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 30),
          Field(
            heading: "Notice Period",
            hint: "Month",
            keyboardType: TextInputType.text,
            onChange: (value) {
              pgFormController.pgFormModel.update((val) {
                val!.noticePeriod = value;
              });
            },
          ),
          const SizedBox(height: 15),
          Field(
            heading: "Operating Since",
            hint: "Year",
            keyboardType: TextInputType.number,
            onChange: (value) {
              pgFormController.pgFormModel.update((val) {
                val!.operatingSince = value;
              });
            },
          ),
          const SizedBox(height: 15),
          Field(
            maxLines: 5,
            heading: "Description",
            hint: "Short Description",
            keyboardType: TextInputType.text,
            onChange: (value) {
              pgFormController.pgFormModel.value.description = value;
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

// Container(
//                 decoration: BoxDecoration(
//                     color: const Color(0xFF0EB7B7),
//                     borderRadius: BorderRadius.circular(15),
//                     boxShadow: const [
//                       BoxShadow(
//                         offset: Offset(5, 5),
//                         spreadRadius: -3,
//                         blurRadius: 5,
//                         color: Color.fromRGBO(0, 0, 0, 0.4),
//                       )
//                     ]),
//                 width: MediaQuery.of(context).size.width / 2.1,
//                 height: MediaQuery.of(context).size.height / 15,
//                 child: Center(
//                   child: Text(
//                     "Submit",
//                     style: Get.textTheme.headline5!.copyWith(
//                         color: Colors.white, fontWeight: FontWeight.w600),
//                   ),
//                 ),
//               ),

// InkWell(
//               onTap: () {

//                 print(pgFormController.extra_details);
//                 print(pgFormController.roomType);
//                 print(pgFormController.rents);
//                 print(pgFormController.details);
//               },
//               child:
//             ),

// List<DropdownMenuItem<String>> iteams_0 = [
//   const DropdownMenuItem(
//     value: "N/A",
//     child: Text("N/A"),
//   ),
//   const DropdownMenuItem(
//     value: "Students",
//     child: Text("Students"),
//   ),
// ];
// List<DropdownMenuItem<String>> iteams_1 = [
//   const DropdownMenuItem(
//     value: "N/A",
//     child: Center(
//       child: Text(
//         "N/A",
//       ),
//     ),
//   ),
//   const DropdownMenuItem(
//     value: "Available",
//     child: Text("Available"),
//   ),
//   const DropdownMenuItem(
//     value: "Not Available",
//     child: Text("Not Available"),
//   )
// ];
// List<DropdownMenuItem<String>> iteams_2 = [
//   const DropdownMenuItem(
//     value: "N/A",
//     child: Text("N/A"),
//   ),
//   const DropdownMenuItem(
//     value: "Included",
//     child: Text("Included"),
//   ),
//   const DropdownMenuItem(
//     value: "Not Included",
//     child: Text("Not Included"),
//   ),
// ];
// List<DropdownMenuItem<String>> iteams_3 = [
//   const DropdownMenuItem(
//     value: "N/A",
//     child: Text("N/A"),
//   ),
//   const DropdownMenuItem(
//     value: "Male",
//     child: Text("Male"),
//   ),
//   const DropdownMenuItem(
//     value: "Female",
//     child: Text("Female"),
//   ),
//   const DropdownMenuItem(
//     value: "Both",
//     child: Text("Both"),
//   ),
// ];
// List<DropdownMenuItem<String>> iteams_4 = [
//   const DropdownMenuItem(
//     value: "N/A",
//     child: Text("N/A"),
//   ),
//   const DropdownMenuItem(
//     value: "Furnished",
//     child: Text("Furnished"),
//   ),
//   const DropdownMenuItem(
//     value: "Semi Furnished",
//     child: Text("Semi Furnished"),
//   ),
//   const DropdownMenuItem(
//     value: "Not Furnished",
//     child: Text("Not Furnished"),
//   ),
// ];

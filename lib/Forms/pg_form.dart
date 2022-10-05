import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/pg_form_controller.dart';
import 'package:househunt/utils/dropdown_util.dart';
import 'package:househunt/widgets/dropdown_button.dart';
import 'package:househunt/widgets/input_field.dart';

class PgForm extends StatefulWidget {
  const PgForm({Key? key}) : super(key: key);

  @override
  State<PgForm> createState() => _PgFormState();
}

class _PgFormState extends State<PgForm> {
  int single = 0;
  int double = 0;
  int triple = 0;
  int quadruple = 0;

  // insert controller
  PgFormController pgFormController = Get.put(PgFormController());

  final items0 = generateItems(["N/A", "Students"]);
  final items1 = generateItems(["N/A", "Available", "Not Available"]);
  final items2 = generateItems(["N/A", "Included", "Not Included"]);
  final items3 = generateItems(["N/A", "Male", "Female", "Both"]);
  final items4 =
      generateItems(["N/A", "Furnished", "Semi Furnished", "Not Furnished"]);

  // Widget dropdownButton(String name, List<DropdownMenuItem<String>> iteam,
  //         Map<String, String> Details) =>

  Widget Button(String type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.5,
          height: 70,
          child: Card(
            color: const Color(0xFF0EB7B7),
            elevation: 5,
            child: Center(
              child: Text(
                type,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
        const Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 13,
          child: TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: "Enter the amount",
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Color(0xFF0EB7B7), width: 1),
              ),
            ),
            onChanged: (value) {
              pgFormController.rents["$type rent"] = value;
            },
          ),
        ),
      ],
    );
  }

  // Expanded TypeSelector(int type, String TypeName) {
  //   return Expanded(
  //     child: ElevatedButton(
  //       onPressed: () {
  //         if (type == 0) {
  //           Room_type.add(TypeName);
  //         }
  //         if (type == 1) {
  //           if (Room_type.isNotEmpty) {
  //             Room_type.remove(TypeName);
  //           }
  //         }
  //         setState(() {
  //           type == 0 ? type = 1 : type = 0;
  //         });
  //       },
  //       style: ButtonStyle(
  //           backgroundColor: MaterialStateProperty.all(
  //               type == 0 ? Colors.white : const Color(0xFF0EB7B7))),
  //       child: Text(
  //         TypeName,
  //         style: TextStyle(color: Colors.black),
  //       ),
  //     ),
  //   );
  // }

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
              pgFormController.extraDetails['Address'] = value;
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
              pgFormController.extraDetails['No. of Rooms'] = value;
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
                          backgroundColor: MaterialStateProperty.all(single == 0
                              ? Colors.white
                              : const Color(0xFF0EB7B7))),
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
                          backgroundColor: MaterialStateProperty.all(double == 0
                              ? Colors.white
                              : const Color(0xFF0EB7B7))),
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
                          backgroundColor: MaterialStateProperty.all(triple == 0
                              ? Colors.white
                              : const Color(0xFF0EB7B7))),
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
                              quadruple == 0
                                  ? Colors.white
                                  : const Color(0xFF0EB7B7))),
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
                    border:
                        Border.all(width: 1, color: const Color(0xFF0EB7B7))),
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
                    if (single == 1) Button("Single"),
                    const SizedBox(height: 7),
                    if (double == 1) Button("Double"),
                    const SizedBox(height: 7),
                    if (triple == 1) Button("Triple"),
                    const SizedBox(height: 7),
                    if (quadruple == 1) Button("Quadruple"),
                    const SizedBox(height: 7),
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
                  items: items1,
                  onChange: (value) {
                    pgFormController.details['Power Backup'] = value;
                  },
                  value: pgFormController.details['Power Backup'] ?? "N/A",
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "AC Rooms",
                  items: items1,
                  onChange: (value) {
                    pgFormController.details['AC Rooms'] = value;
                  },
                  value: pgFormController.details['AC Rooms'] ?? "N/A",
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
                    pgFormController.details['Maintenance'] = value;
                  },
                  value: pgFormController.details['Maintenance'] ?? "N/A",
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "Electricity Charges",
                  items: items2,
                  onChange: (value) {
                    pgFormController.details['Electricity Charges",'] = value;
                  },
                  value: pgFormController.details['Electricity Charges",'] ??
                      "N/A",
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
                  items: items3,
                  onChange: (value) {
                    pgFormController.details['Available for'] = value;
                  },
                  value: pgFormController.details['Available for'] ?? "N/A",
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "Preferred Tenants",
                  items: items0,
                  onChange: (value) {
                    pgFormController.details['Preferred Tenants'] = value;
                  },
                  value: pgFormController.details['Preferred Tenants'] ?? "N/A",
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
                    pgFormController.details['Food'] = value;
                  },
                  value: pgFormController.details['Food'] ?? "N/A",
                ),
              ),
              const Spacer(),
              Obx(
                () => DropDownButton(
                  name: "Wifi",
                  items: items1,
                  onChange: (value) {
                    pgFormController.details['Wifi'] = value;
                  },
                  value: pgFormController.details['Wifi'] ?? "N/A",
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
                  items: items4,
                  onChange: (value) {
                    pgFormController.details['Furniture'] = value;
                  },
                  value: pgFormController.details['Furniture'] ?? "N/A",
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
              pgFormController.extraDetails['Notice Period'] = value;
            },
          ),
          const SizedBox(height: 15),
          Field(
            heading: "Operating Since",
            hint: "Year",
            keyboardType: TextInputType.number,
            onChange: (value) {
              pgFormController.extraDetails['Operating Since'] = value;
            },
          ),
          const SizedBox(height: 15),
          Field(
            maxLines: 5,
            heading: "Description",
            hint: "Short Description",
            keyboardType: TextInputType.text,
            onChange: (value) {
              pgFormController.extraDetails['Description'] = value;
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
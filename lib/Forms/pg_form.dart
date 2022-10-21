import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/pg_form_controller.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:househunt/utils/dropdown_util.dart';
import 'package:househunt/widgets/custom_button.dart';
import 'package:househunt/widgets/dropdown_button.dart';
import 'package:househunt/widgets/input_field.dart';
import 'package:househunt/controllers/firebase_controller.dart';

class PgForm extends StatefulWidget {
  const PgForm({Key? key}) : super(key: key);

  @override
  State<PgForm> createState() => _PgFormState();
}

class _PgFormState extends State<PgForm> {
  // insert controller
  PgFormController pgFormController = Get.put(PgFormController());
  final FireBaseController fireBaseController = Get.put(FireBaseController());
  @override
  void initState() {
    // get arguments
    final args = Get.arguments;

    if (args == null) {
      pgFormController.clearTextControllers();
      pgFormController.clearRoomRents();
      pgFormController.clearDropdowns();

      if (pgFormController.assets.isNotEmpty) {
        pgFormController.assets.clear();
      }
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Field(
              heading: 'Pg Name',
              controller: pgFormController.nameController.value,
              hint: 'Name',
              onChange: (String value) {
                pgFormController.pgFormModel.value.pgName = value;
              },
            ),
            const SizedBox(
              height: 5,
            ),
            //
            Field(
              heading: 'Address',
              controller: pgFormController.addressController.value,
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
              controller: pgFormController.roomsController.value,
              keyboardType: TextInputType.number,
              onChange: (value) {
                pgFormController.pgFormModel.value.noOfRooms = value;
              },
            ),
            const SizedBox(
              height: 30,
            ),
            Obx(
              () => Column(
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
                            if (!pgFormController.singleRoom.value) {
                              pgFormController.roomType.add("Single");
                            } else {
                              if (pgFormController.roomType.isNotEmpty) {
                                pgFormController.roomType.remove("Single");
                              }
                            }
                            pgFormController.singleRoom.value =
                                !pgFormController.singleRoom.value;
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              !pgFormController.singleRoom.value
                                  ? Colors.white
                                  : primary,
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
                            if (!pgFormController.doubleRoom.value) {
                              pgFormController.roomType.add("Double");
                            } else {
                              if (pgFormController.roomType.isNotEmpty) {
                                pgFormController.roomType.remove("Double");
                              }
                            }
                            pgFormController.doubleRoom.value =
                                !pgFormController.doubleRoom.value;
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              !pgFormController.doubleRoom.value
                                  ? Colors.white
                                  : primary,
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
                            if (!pgFormController.tripleRoom.value) {
                              pgFormController.roomType.add("Triple");
                            } else {
                              if (pgFormController.roomType.isNotEmpty) {
                                pgFormController.roomType.remove("Triple");
                              }
                            }

                            pgFormController.tripleRoom.value =
                                !pgFormController.tripleRoom.value;
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              !pgFormController.tripleRoom.value
                                  ? Colors.white
                                  : primary,
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
                            if (!pgFormController.fourRoom.value) {
                              pgFormController.roomType.add("Quadruple");
                            } else {
                              if (pgFormController.roomType.isNotEmpty) {
                                pgFormController.roomType.remove("Quadruple");
                              }
                            }
                            pgFormController.fourRoom.value =
                                !pgFormController.fourRoom.value;
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                              !pgFormController.fourRoom.value
                                  ? Colors.white
                                  : primary,
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
            ),
            const SizedBox(height: 20),
            Obx(
              () => Column(
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
                        if (!pgFormController.singleRoom.value &&
                            !pgFormController.doubleRoom.value &&
                            !pgFormController.tripleRoom.value &&
                            !pgFormController.fourRoom.value)
                          const Center(
                            child: Text("Choose appropriate type"),
                          ),
                        if (pgFormController.singleRoom.value) ...[
                          CustomButton(
                              controller: pgFormController
                                  .singleRoomRentController.value,
                              type: "Single",
                              onPressed: (value) {
                                pgFormController
                                    .pgFormModel.value.singleRoomRent = value;
                              }),
                          const SizedBox(height: 7),
                        ],
                        if (pgFormController.doubleRoom.value) ...[
                          CustomButton(
                              controller: pgFormController
                                  .doubleRoomRentController.value,
                              type: "Double",
                              onPressed: (value) {
                                pgFormController
                                    .pgFormModel.value.doubleRoomRent = value;
                              }),
                          const SizedBox(height: 7),
                        ],
                        if (pgFormController.tripleRoom.value) ...[
                          CustomButton(
                              controller: pgFormController
                                  .tripleRoomRentController.value,
                              type: "Triple",
                              onPressed: (value) {
                                pgFormController
                                    .pgFormModel.value.tripleRoomRent = value;
                              }),
                          const SizedBox(height: 7),
                        ],
                        if (pgFormController.fourRoom.value) ...[
                          CustomButton(
                              controller:
                                  pgFormController.fourRoomRentController.value,
                              type: "Quadruple",
                              onPressed: (value) {
                                pgFormController
                                    .pgFormModel.value.fourRoomRent = value;
                              }),
                          const SizedBox(height: 7),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
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
                    value:
                        pgFormController.pgFormModel.value.electricityCharges,
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
              controller: pgFormController.noticePeriodController.value,
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
              controller: pgFormController.operatingSinceController.value,
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
              controller: pgFormController.descriptionController.value,
              keyboardType: TextInputType.text,
              onChange: (value) {
                pgFormController.pgFormModel.value.description = value;
              },
            ),
            const SizedBox(height: 15),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  if (pgFormController.disabledButton.value) return;
                  FocusManager.instance.primaryFocus?.unfocus();
                  fireBaseController.uploadFilePg();
                  pgFormController.submitForm();
                  // print all the values of the form
                },
                child: SizedBox(
                  width: Get.width / 2.75,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Center(
                      child: Text(
                        "Submit",
                        style: Get.textTheme.headline6!.copyWith(
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
      ),
    );
  }
}

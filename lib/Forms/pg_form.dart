import 'package:flutter/material.dart';

class PgForm extends StatefulWidget {
  const PgForm({Key? key}) : super(key: key);

  @override
  State<PgForm> createState() => _PgFormState();
}

class _PgFormState extends State<PgForm> {
  int Single = 0;
  int double = 0;
  int triple = 0;
  int quadruple = 0;
  Map<String, String> extra_details = {
    "Address": "",
    "No. of Rooms": "",
    "Notice Period": "",
    "Operating Since": "",
    "Description": "",
  };
  List<String> Room_type = [];
  Map<String, String> rents = {
    "Single rent": "",
    "Double rent": "",
    "Triple rent": "",
    "Quadruple rent": "",
  };
  Map<String, String> Details = {
    "Power Backup": "N/A", //index 0
    "AC Rooms": "N/A", //index 1
    "Maintenance": "N/A", //index 2
    "Electicity Charges": "N/A", //index 3
    "Available for": "N/A", // index 4
    "Preferd Tenants": "N/A", // index 5
    "Food": "N/A", // index 6
    "Wifi": "N/A", // index 7
    "Furniture": "N/A", // else
  };
  List<DropdownMenuItem<String>> iteams_0 = [
    const DropdownMenuItem(
      value: "N/A",
      child: Text("N/A"),
    ),
    const DropdownMenuItem(
      value: "Students",
      child: Text("Students"),
    ),
  ];
  List<DropdownMenuItem<String>> iteams_1 = [
    const DropdownMenuItem(
      value: "N/A",
      child: Text("N/A"),
    ),
    const DropdownMenuItem(
      value: "Available",
      child: Text("Available"),
    ),
    const DropdownMenuItem(
      value: "Not Available",
      child: Text("Not Available"),
    )
  ];
  List<DropdownMenuItem<String>> iteams_2 = [
    const DropdownMenuItem(
      value: "N/A",
      child: Text("N/A"),
    ),
    const DropdownMenuItem(
      value: "Included",
      child: Text("Included"),
    ),
    const DropdownMenuItem(
      value: "Not Included",
      child: Text("Not Included"),
    ),
  ];
  List<DropdownMenuItem<String>> iteams_3 = [
    const DropdownMenuItem(
      value: "N/A",
      child: Text("N/A"),
    ),
    const DropdownMenuItem(
      value: "Male",
      child: Text("Male"),
    ),
    const DropdownMenuItem(
      value: "Female",
      child: Text("Female"),
    ),
    const DropdownMenuItem(
      value: "Both",
      child: Text("Both"),
    ),
  ];
  List<DropdownMenuItem<String>> iteams_4 = [
    const DropdownMenuItem(
      value: "N/A",
      child: Text("N/A"),
    ),
    const DropdownMenuItem(
      value: "Furnished",
      child: Text("Furnished"),
    ),
    const DropdownMenuItem(
      value: "Semi Furnished",
      child: Text("Semi Furnished"),
    ),
    const DropdownMenuItem(
      value: "Not Furnished",
      child: Text("Not Furnished"),
    ),
  ];
  Widget dropdownbutton(String name, List<DropdownMenuItem<String>> iteam,
      Map<String, String> Details) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name),
        SizedBox(height: 6),
        Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: MediaQuery.of(context).size.height / 13,
          padding: EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Color(0xFF0EB7B7),
                width: 1,
              )),
          child: SizedBox(
            child: DropdownButton(
                isExpanded: true,
                underline: Container(),
                value: Details[name],
                items: iteam,
                onChanged: (value) async {
                  setState(() {
                    Details[name] = value.toString();
                  });
                }),
          ),
        )
      ],
    );
  }

  Widget Button(String type) {
    return Row(children: [
      SizedBox(
        width: MediaQuery.of(context).size.width / 2.5,
        height: MediaQuery.of(context).size.height / 13,
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
              borderSide: const BorderSide(color: Color(0xFF0EB7B7), width: 1),
            ),
          ),
          onChanged: (value) {
            setState(() {
              rents["$type rent"] = value;
            });
          },
        ),
      ),
    ]);
  }

  Widget Field(String heading, String hint, dynamic keyboardtype) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 10,
        ),
        TextField(
          keyboardType: keyboardtype,
          decoration: InputDecoration(
              hintText: hint,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Color(0xFF0EB7B7), width: 1),
              )),
          onChanged: (value) {
            setState(() {
              extra_details[heading] = value;
            });
          },
        ),
        const SizedBox(
          height: 19,
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
          Field("Address", "Address", TextInputType.text),
          const SizedBox(
            height: 5,
          ),
          Field("No. of Rooms", "Rooms", TextInputType.number),
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
                        if (Single == 0) {
                          Room_type.add("Single");
                        }
                        if (Single == 1) {
                          if (Room_type.isNotEmpty) {
                            Room_type.remove("Single");
                          }
                        }
                        setState(() {
                          Single == 0 ? Single = 1 : Single = 0;
                        });
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Single == 0
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
                          Room_type.add("Double");
                        }
                        if (double == 1) {
                          if (Room_type.isNotEmpty) {
                            Room_type.remove("Double");
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
                          Room_type.add("Triple");
                        }
                        if (triple == 1) {
                          if (Room_type.isNotEmpty) {
                            Room_type.remove("Triple");
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
                          Room_type.add("Quadruple");
                        }
                        if (quadruple == 1) {
                          if (Room_type.isNotEmpty) {
                            Room_type.remove("Quadruple");
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
                    borderRadius: BorderRadius.circular(20),
                    border:
                        Border.all(width: 1, color: const Color(0xFF0EB7B7))),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (Single == 0 &&
                        double == 0 &&
                        triple == 0 &&
                        quadruple == 0)
                      const Center(child: Text("Choose appropriate type")),
                    if (Single == 1) Button("Single"),
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
              dropdownbutton("Power Backup", iteams_1, Details),
              const Spacer(),
              dropdownbutton("AC Rooms", iteams_1, Details),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              dropdownbutton("Maintenance", iteams_2, Details),
              const Spacer(),
              dropdownbutton("Electicity Charges", iteams_2, Details),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              dropdownbutton("Available for", iteams_3, Details),
              const Spacer(),
              dropdownbutton("Preferd Tenants", iteams_0, Details),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              dropdownbutton("Food", iteams_1, Details),
              const Spacer(),
              dropdownbutton("Wifi", iteams_1, Details),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              const Spacer(),
              dropdownbutton("Furniture", iteams_4, Details),
              const Spacer(),
            ],
          ),
          const SizedBox(height: 30),
          Field("Notice Period", "Month", TextInputType.text),
          const SizedBox(height: 15),
          Field("Operating Since", "Year", TextInputType.number),
          const SizedBox(height: 15),
          Field("Description", "Short Description", TextInputType.text),
          const SizedBox(height: 15),
          Center(
            child: InkWell(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                print(extra_details);
                print(Room_type);
                print(rents);
                print(Details);
              },
              child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFF0EB7B7),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  width: MediaQuery.of(context).size.width / 2.1,
                  height: MediaQuery.of(context).size.height / 15,
                  child: const Center(
                    child: Text("Submit"),
                  )),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
    );
  }
}

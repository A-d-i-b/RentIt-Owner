import 'package:flutter/material.dart';

class FlatForm extends StatefulWidget {
  const FlatForm({Key? key}) : super(key: key);

  @override
  State<FlatForm> createState() => _FlatFormState();
}

class _FlatFormState extends State<FlatForm> {
  Map<String, String> extra_details = {
    "Address": "",
    "No. of Rooms": "",
    "Rent": "",
    "Notice Period": "",
    "Description": "",
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
    "Furniture": "N/A",
    "BHK": "N/A", // else
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
  List<DropdownMenuItem<String>> Bhk() {
    List<DropdownMenuItem<String>> iteam_5 = [
      const DropdownMenuItem(
        value: "N/A",
        child: Text("N/A"),
      ),
    ];
    for (int i = 1; i < 5; i++) {
      iteam_5.add(
        DropdownMenuItem(
          value: "$i",
          child: Text("$i"),
        ),
      );
    }
    return iteam_5;
  }

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
          SizedBox(height: 5),
          Field("Rent", "Amount", TextInputType.number),
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
              dropdownbutton("Furniture", iteams_4, Details),
              const Spacer(),
              dropdownbutton("BHK", Bhk(), Details),
            ],
          ),
          const SizedBox(height: 30),
          Field("Notice Period", "Month", TextInputType.text),
          const SizedBox(height: 15),
          Field("Built In", "Year", TextInputType.number),
          const SizedBox(height: 15),
          Field("Description", "Short Description", TextInputType.text),
          const SizedBox(height: 15),
          Center(
            child: InkWell(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                print(extra_details);
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

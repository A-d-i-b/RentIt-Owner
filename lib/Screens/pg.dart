import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PgHome extends StatefulWidget {
  const PgHome({Key? key}) : super(key: key);

  @override
  createState() => _PgState();
}

class _PgState extends State<PgHome> {
  List<XFile>? pickImages = [];
  int method = 2;
  void selectImage() async {
    if (method == 0) {
      List<XFile>? selectedImages = await ImagePicker().pickMultiImage();
      setState(() {
        if (selectedImages!.isNotEmpty) {
          pickImages!.addAll(selectedImages);
        }
      });
    } else {
      XFile? selectedImages =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (selectedImages != null) {
        setState(() {
          pickImages!.add(selectedImages);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: const Color(0xFF0EB7B7),
        title: const Text(
          "Paying Guest",
          style: TextStyle(
            color: Colors.black,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Container(
            height: 190,
            margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: const Color(0xFF0EB7B7),
                  width: 1.6,
                )),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GridView.builder(
                      padding: const EdgeInsets.all(5),
                      itemCount: pickImages!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onLongPress: () {
                              setState(() {
                                pickImages!.removeAt(index);
                              });
                            },
                            child: Container(
                                margin: const EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: const Color(0xFF0EB7B7),
                                        width: 2)),
                                child:
                                    Image.file(File(pickImages![index].path))));
                      }),
                  if (pickImages!.isEmpty)
                    Text(
                      "No Images Added",
                      style: TextStyle(color: Colors.grey[400], fontSize: 20),
                    )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      method = 0;
                    });

                    selectImage();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF0EB7B7)),
                  ),
                  child: const Text("Select from gallery"),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      method = 1;
                    });
                    selectImage();
                  },
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(const Color(0xFF0EB7B7)),
                  ),
                  child: const Text("Take a Photo"),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

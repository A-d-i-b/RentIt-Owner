import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Pghome extends StatefulWidget {
  @override
  State<Pghome> createState() => _PgState();
}

class _PgState extends State<Pghome> {
  List<XFile>? pickimages = [];
  int method = 2;
  void selectimage() async {
    if (method == 0) {
      List<XFile>? selectimage = await ImagePicker().pickMultiImage();
      setState(() {
        if (selectimage!.isNotEmpty) {
          pickimages!.addAll(selectimage);
        }
      });
    } else {
      XFile? selectimage =
          await ImagePicker().pickImage(source: ImageSource.camera);
      if (selectimage != null) {
        setState(() {
          pickimages!.add(selectimage);
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
            margin: EdgeInsets.only(top: 30, left: 20, right: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Color(0xFF0EB7B7),
                  width: 1.6,
                )),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  GridView.builder(
                      padding: EdgeInsets.all(5),
                      itemCount: pickimages!.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3),
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                            onLongPress: () {
                              setState(() {
                                pickimages!.removeAt(index);
                              });
                            },
                            child: Container(
                                margin: EdgeInsets.all(2),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    border: Border.all(
                                        color: Color(0xFF0EB7B7), width: 2)),
                                child:
                                    Image.file(File(pickimages![index].path))));
                      }),
                  if (pickimages!.isEmpty)
                    Text(
                      "No Images Added",
                      style: TextStyle(color: Colors.grey[400], fontSize: 20),
                    )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 20, right: 20),
            child: Row(
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      method = 0;
                    });

                    selectimage();
                  },
                  child: Text("Select from gallery"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF0EB7B7)),
                  ),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      method = 1;
                    });
                    selectimage();
                  },
                  child: Text("Take a Photo"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(Color(0xFF0EB7B7)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

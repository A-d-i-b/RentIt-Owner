import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/Forms/flat_form.dart';
import 'package:househunt/widgets/asset_picker.dart';
import 'package:image_picker/image_picker.dart';

class FlatHome extends StatefulWidget {
  const FlatHome({Key? key}) : super(key: key);

  @override
  createState() => _FlatState();
}

class _FlatState extends State<FlatHome> {
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
        title: Text(
          "Flat",
          style: Get.textTheme.headline4!.copyWith(
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: const AssetPickerWidget()),
          const SizedBox(
            height: 20,
          ),
          FlatForm(),
        ],
      ),
    );
  }
}

// Container(
//             height: 190,
//             margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(10),
//                 border: Border.all(
//                   color: const Color(0xFF0EB7B7),
//                   width: 1.6,
//                 )),
//             child: Center(
//               child: Stack(
//                 alignment: Alignment.center,
//                 children: [
//                   GridView.builder(
//                       padding: const EdgeInsets.all(5),
//                       itemCount: pickImages!.length,
//                       gridDelegate:
//                           const SliverGridDelegateWithFixedCrossAxisCount(
//                               crossAxisCount: 3),
//                       itemBuilder: (BuildContext context, int index) {
//                         return InkWell(
//                           onLongPress: () {
//                             setState(() {
//                               pickImages!.removeAt(index);
//                             });
//                           },
//                           child: Container(
//                             margin: const EdgeInsets.all(2),
//                             decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(5),
//                               border: Border.all(
//                                   color: const Color(0xFF0EB7B7), width: 1),
//                             ),
//                             child: Image.file(
//                               File(pickImages![index].path),
//                               fit: BoxFit.cover,
//                             ),
//                           ),
//                         );
//                       }),
//                   if (pickImages!.isEmpty)
//                     Text(
//                       "No Images Added",
//                       style: TextStyle(color: Colors.grey[400], fontSize: 20),
//                     )
//                 ],
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 20, right: 20),
//             child: Row(
//               children: [
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       method = 0;
//                     });

//                     selectImage();
//                   },
//                   style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all(const Color(0xFF0EB7B7)),
//                   ),
//                   child: const Text("Select from gallery"),
//                 ),
//                 const Spacer(),
//                 ElevatedButton(
//                   onPressed: () {
//                     setState(() {
//                       method = 1;
//                     });
//                     selectImage();
//                   },
//                   style: ButtonStyle(
//                     backgroundColor:
//                         MaterialStateProperty.all(const Color(0xFF0EB7B7)),
//                   ),
//                   child: const Text("Take a Photo"),
//                 ),
//               ],
//             ),
//           )
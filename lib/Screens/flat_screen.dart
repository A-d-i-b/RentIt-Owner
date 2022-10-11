import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/Forms/flat_form.dart';
import 'package:househunt/controllers/flat_form_controller.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:househunt/widgets/asset_picker.dart';
import 'package:househunt/widgets/asset_thumb.dart';

class FlatHome extends StatelessWidget {
  FlatHome({Key? key}) : super(key: key);

  final FlatFormController flatFormController = Get.put(FlatFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: primary,
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
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Media',
                  style: Get.textTheme.headline6,
                ),
                const SizedBox(
                  height: 10,
                ),
                // display assets
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => Row(
                      children: flatFormController.assets
                          .map(
                            (element) => AssetThumb(
                                onRemove: () {
                                  flatFormController.assets.remove(element);
                                },
                                file: element),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                AssetPickerWidget(
                  onAssetPicked: (items) {
                    flatFormController.assets.addAll(
                      items.map(
                        (e) => File(e.path),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const FlatForm(),
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

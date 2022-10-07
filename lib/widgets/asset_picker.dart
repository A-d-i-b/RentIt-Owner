import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AssetPickerWidget extends StatelessWidget {
  const AssetPickerWidget({Key? key, required this.onAssetPicked})
      : super(key: key);

  final void Function(List<XFile>) onAssetPicked;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: handleClick,
      child: const Text('Pick Assets'),
    );
  }

  handleClick() async {
    final ImagePicker picker = ImagePicker();

    // show action sheet

    Get.bottomSheet(
      Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        height: Get.height * 0.3,
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Camera'),
              onTap: () async {
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  onAssetPicked([image]);
                }
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.videocam),
              title: const Text('Record'),
              onTap: () async {
                final XFile? image = await picker.pickVideo(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  onAssetPicked([image]);
                }
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () async {
                final List<XFile>? image = await picker.pickMultiImage(
                  imageQuality: 50,
                );
                if (image != null) {
                  onAssetPicked(image);
                }
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.video_collection),
              title: const Text('Video Gallery'),
              onTap: () async {
                final XFile? image = await picker.pickVideo(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  onAssetPicked([image]);
                }
                Get.back();
              },
            ),
          ],
        ),
      ),
    );

    // showBottomSheet(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return Container(
    //         child: const Text('HELLO'),
    //       );
    //     });
  }
}

// class AssetThumb extends StatelessWidget {
//   const AssetThumb({
//     Key? key,
//     required this.asset,
//     required this.width,
//     required this.height,
//   }) : super(key: key);

//   final AssetEntity asset;
//   final double width;
//   final double height;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: width,
//       height: height,
//       child: FutureBuilder(
//         future: asset.file,
//         builder: (context, snapshot) => snapshot.hasData
//             ? Image.file(
//                 snapshot.data as File,
//                 fit: BoxFit.cover,
//               )
//             : // tween animation container loading
//             Container(
//                 color: Colors.grey,
//               ),
//       ),
//     );
//   }
// }


//  ElevatedButton(
//       onPressed: () async {
//         final assets = await AssetPicker.pickAssets(
//           context,
//         );
//         setState(() {
//           _assets = assets;
//         });
//       },
//       child: const Text('Press me bitch'),
//     );
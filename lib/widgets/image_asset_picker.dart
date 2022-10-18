import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatelessWidget {
  const UserImagePicker({Key? key, required this.onAssetPicked})
      : super(key: key);

  final void Function(XFile) onAssetPicked;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handleClick,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: primary,
        ),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
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
        height: Get.height * 0.17,
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
                  onAssetPicked(image);
                }
                Get.back();
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Gallery'),
              onTap: () async {
                final XFile? image = await picker.pickImage(
                  imageQuality: 50,
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  onAssetPicked(image);
                }
                Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}

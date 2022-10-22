import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:househunt/widgets/image_asset_picker.dart';
import 'package:househunt/controllers/firebase_controller.dart';

class OwnerUpdate extends StatefulWidget {
  const OwnerUpdate({Key? key}) : super(key: key);

  @override
  State<OwnerUpdate> createState() => _OwnerUpdateState();
}

class _OwnerUpdateState extends State<OwnerUpdate> {
  final UserController userController = Get.put(UserController());
  final FireBaseController fireBaseController = Get.put(FireBaseController());
  @override
  Widget build(BuildContext context) {
    final profileImage = Image.asset(
      'images/ownerpic.jpg',
      fit: BoxFit.cover,
    ); //TODO: Update this pic using image picker also update to the database
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        title: Text(
          "My Account",
          style: Get.textTheme.headline4,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          Obx(
            () => Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: Container(
                    // radius: 60,
                    // backgroundImage: profileImage.image,
                    width: Get.width / 2,
                    height: Get.width / 2,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: userController.updatedImage.value.path != ''
                            ? FileImage(
                                File(userController.updatedImage.value.path),
                              )
                            : profileImage.image,
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: userController.user.value.imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(60),
                              child: Image.network(fireBaseController.getUrl()),
                            )
                          : null,
                    ),
                  ),
                ),
                Positioned(
                  right: Get.width * 0.19,
                  bottom: Get.height * 0.01,
                  child: UserImagePicker(
                    onAssetPicked: (file) {
                      userController.updatedImage.value = file;
                    },
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Form(
              child: Column(
            children: [
              Obx(
                () => TextField(
                  onChanged: (val) {
                    //TODO:change the value of name
                  },
                  controller: TextEditingController(
                    text: userController.user.value.name,
                  ),
                  decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(20),
                        child: Icon(Icons.person),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: primary,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: primary,
                        ),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      labelText: 'Name'),
                ),
              ),
              const SizedBox(height: 30),
              Obx(
                () => TextField(
                  onChanged: (val) {
                    //TODO:change the value of phone
                  },
                  controller: TextEditingController(
                      text: userController.user.value.phone),
                  decoration: const InputDecoration(
                      prefixIcon: Padding(
                        padding: EdgeInsets.all(20),
                        child: Icon(Icons.phone),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: primary,
                        ),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: primary,
                        ),
                      ),
                      errorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      focusedErrorBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                        ),
                      ),
                      labelText: 'Phone No.'),
                ),
              ),
              const SizedBox(height: 20),
            ],
          )),
          SizedBox(
            height: Get.height / 16,
            child: ElevatedButton(
              child: const Text("Update"),
              onPressed: () {
                // fireBaseController
                //     .uploadFileProfile(userController.user.value.id);
                fireBaseController.getUrl();
              },
            ),
          ),
        ],
      ),
    );
  }
}

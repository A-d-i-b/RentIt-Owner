import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/sign_up_controller.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/http_connects/auth_controller.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:househunt/widgets/image_asset_picker.dart';
import 'package:househunt/controllers/firebase_controller.dart';
import 'package:image_picker/image_picker.dart';

class OwnerUpdate extends StatefulWidget {
  const OwnerUpdate({Key? key}) : super(key: key);

  @override
  State<OwnerUpdate> createState() => _OwnerUpdateState();
}

class _OwnerUpdateState extends State<OwnerUpdate> {
  final UserController userController = Get.put(UserController());
  final FireBaseController fireBaseController = Get.put(FireBaseController());
  final AuthConnect authConnect = Get.put(AuthConnect());
  final SignUpController signUpController = Get.put(SignUpController());
  Rx<String> firstName = ''.obs;
  Rx<String> lastName = ''.obs;
  @override
  Widget build(BuildContext context) {
    final profileImage = Image.asset(
      'images/ownerpic.jpg',
      fit: BoxFit.cover,
    );
    return WillPopScope(
      onWillPop: () async {
        firstName.value = '';
        lastName.value = '';
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0.0,
          foregroundColor: Colors.blue,
          backgroundColor: Colors.transparent,
          title: Text(
            "Update Account",
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
                      width: Get.width / 2,
                      height: Get.width / 2,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(120),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(120),
                        child: userController.updatedImage.value.path != ''
                            ? Image.file(
                                File(userController.updatedImage.value.path),
                                fit: BoxFit.cover,
                              )
                            : (userController.image.value != ''
                                ? CachedNetworkImage(
                                    imageUrl: userController.image.value,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) =>
                                        const SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: CircularProgressIndicator(),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        const Icon(Icons.error),
                                  )
                                : profileImage),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => textField(firstName.value,
                      userController.user.value.firstName, 'First Name'),
                ),
                const SizedBox(height: 30),
                TextField(
                  onChanged: (val) {
                    lastName.value = val;
                  },
                  controller: TextEditingController(
                      text: userController.user.value.lastName),
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
                      labelText: 'Last Name'),
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
              child: Obx(
                () => ElevatedButton(
                  child: Text(userController.isUpdating.value
                      ? "Updating..."
                      : "Update"),
                  onPressed: () async {
                    print(firstName.value);
                    print(lastName.value);
                    // if (firstName.value != '') {
                    //   authConnect.updateUser({'firstName': firstName.value},
                    //       userController.user.value.id, userController.jwt);
                    // }
                    // if (lastName.value != '') {
                    //   authConnect.updateUser({'lastName': lastName.value},
                    //       userController.user.value.id, userController.jwt);
                    // }
                    if (userController.isUpdating.value) return;
                    userController.isUpdating.value = true;
                    if (!(userController.updatedImage.value.path == '')) {
                      final url = await FireBaseController.uploadFileProfile(
                        userController.user.value.id,
                        userController.updatedImage.value.path,
                      );
                      userController.image.value =
                          '$url/v=${DateTime.now().microsecondsSinceEpoch}';
                      userController.updatedImage.update((val) {
                        if (val != null) {
                          val = XFile('');
                        }
                      });
                      Get.back();
                    }

                    userController.isUpdating.value = false;
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textField(dynamic name, String text, String lab) {
    return TextField(
      onChanged: (val) {
        name = val;
      },
      controller: TextEditingController(text: text),
      decoration: InputDecoration(
          prefixIcon: const Padding(
            padding: EdgeInsets.all(20),
            child: Icon(Icons.person),
          ),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: primary,
            ),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: primary,
            ),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          focusedErrorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
            ),
          ),
          labelText: lab),
    );
  }
}

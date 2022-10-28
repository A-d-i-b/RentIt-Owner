import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/sign_up_controller.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/http_connects/auth_controller.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:househunt/widgets/alert_dialog.dart';
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
  String firstName = '';
  String lastName = '';
  String mobile = '';
  @override
  Widget build(BuildContext context) {
    final profileImage = Image.asset(
      'images/ownerpic.jpg',
      fit: BoxFit.cover,
    );
    return WillPopScope(
      onWillPop: () async {
        final choice = await alertDialog(
            title: 'Caution',
            content: 'All unsaved changes will be lost. Do you want to exit?');
        if (choice != true) return false;
        firstName = '';
        lastName = '';
        mobile = '';
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
                child: Obx(
              () => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  textField(
                    (val) {
                      firstName = val;
                    },
                    userController.user.value.firstName,
                    'First Name',
                    Icons.person,
                  ),
                  const SizedBox(height: 30),
                  textField(
                    (val) {
                      lastName = val;
                    },
                    userController.user.value.lastName,
                    'Last Name',
                    Icons.person,
                  ),
                  const SizedBox(height: 30),
                  textField(
                    (val) {
                      mobile = val;
                    },
                    userController.user.value.phone,
                    'Phone Number',
                    Icons.phone,
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )),
            SizedBox(
              height: Get.height / 16,
              child: Obx(
                () => ElevatedButton(
                  child: Text(userController.isUpdating.value
                      ? "Updating..."
                      : "Update"),
                  onPressed: () async {
                    if (userController.isUpdating.value) return;
                    userController.isUpdating.value = true;
                    final body = {};

                    if (firstName != '' &&
                        firstName != userController.user.value.firstName) {
                      body['firstName'] = firstName;
                    }
                    if (lastName != '' &&
                        lastName != userController.user.value.lastName) {
                      body['lastName'] = lastName;
                    }
                    if (mobile != '' &&
                        mobile != userController.user.value.phone) {
                      body['phone'] = mobile;
                    }

                    if (body.isEmpty) {
                      userController.isUpdating.value = false;
                      Get.back();
                      return;
                    }
                    userController.updateUser(body);

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

  Widget textField(
      void Function(String)? onChange, String text, String lab, IconData data) {
    return TextField(
      onChanged: onChange,
      controller: TextEditingController(text: text),
      decoration: InputDecoration(
        prefixIcon: Padding(
          padding: const EdgeInsets.all(20),
          child: Icon(data),
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
        labelText: lab,
      ),
    );
  }
}

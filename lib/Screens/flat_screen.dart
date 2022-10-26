import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/Forms/flat_form.dart';
import 'package:househunt/controllers/firebase_controller.dart';
import 'package:househunt/controllers/flat_form_controller.dart';
import 'package:househunt/models/asset_models.dart';
import 'package:househunt/models/flat_form_model.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:househunt/widgets/asset_picker.dart';
import 'package:househunt/widgets/asset_thumb.dart';

class FlatHome extends StatelessWidget {
  FlatHome({Key? key}) : super(key: key);

  final FlatFormController flatFormController = Get.put(FlatFormController());

  @override
  Widget build(BuildContext context) {
    final bool inEditMode = flatFormController.flatFormModel.value.id != null;
    FlatFormModel copy =
        FlatFormModel.from(flatFormController.flatFormModel.value);

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
        leading: inEditMode
            ? IconButton(
                onPressed: () async {
                  // show dialog all unsaved changes will be lost
                  final choice = await Get.dialog<bool>(
                    AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      title: const Text("Are you sure?"),
                      content: const Text(
                          "All unsaved changes will be lost. Do you want to continue?"),
                      actionsPadding:
                          const EdgeInsets.symmetric(horizontal: 16.0),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Get.back(result: false);
                          },
                          child: const Text(
                            "No",
                            style: TextStyle(color: Colors.green),
                          ),
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red,
                          ),
                          onPressed: () {
                            Get.back(result: true);
                          },
                          child: const Text(
                            "Yes",
                          ),
                        ),
                      ],
                    ),
                  );

                  if (choice != true) {
                    return;
                  }

                  flatFormController.flatFormModel.value = copy;

                  flatFormController.updateDropdowns(copy);

                  Get.back();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
              )
            : null,
        actions: [
          if (inEditMode)
            IconButton(
              onPressed: () {
                // show dialog
                Get.dialog<bool>(
                  AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    title: const Text("Caution"),
                    content: const Text(
                        "All details of this flat will be deleted. Do you want to continue?"),
                    actionsPadding:
                        const EdgeInsets.symmetric(horizontal: 16.0),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Get.back(result: false);
                        },
                        child: const Text(
                          "No",
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                        ),
                        onPressed: () {
                          Get.back(result: true);
                        },
                        child: const Text(
                          "Yes",
                        ),
                      ),
                    ],
                  ),
                ).then((value) {
                  if (value == true) {
                    flatFormController.deleteFlat();
                  }
                });
              },
              icon: const Icon(
                Icons.delete,
                color: Colors.black,
              ),
            ),
        ],
      ),
      body: ListView(
        children: [
          const SizedBox(
            height: 20,
          ),
          if (!inEditMode)
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
                              (el) => AssetThumb(
                                onRemove: () {
                                  flatFormController.assets.remove(el);
                                },
                                file: FileImage(el.file),
                                isVideo: el.type == AssetType.video,
                              ),
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
                          (e) =>
                              FileAsset(file: File(e.file.path), type: e.type),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          if (inEditMode)
            FutureBuilder(
              future: FireBaseController.getAssets(
                flatFormController.flatFormModel.value.id!,
              ),
              builder: (context, AsyncSnapshot<List<String>> snapshot) {
                if (snapshot.hasData) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Edit Media',
                          style: Get.textTheme.headline6,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        // display assets
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: snapshot.data!
                                .map(
                                  (el) => AssetThumb(
                                    onRemove: () {
                                      // pgFormController.assets.remove(el);
                                    },
                                    file: CachedNetworkImageProvider(el),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        AssetPickerWidget(
                          onAssetPicked: (items) {
                            flatFormController.assets.addAll(
                              items.map(
                                (e) => FileAsset(
                                    file: File(e.file.path), type: e.type),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          const SizedBox(
            height: 20,
          ),
          FlatForm(),
        ],
      ),
    );
  }
}

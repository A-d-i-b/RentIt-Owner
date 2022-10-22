import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/Forms/flat_form.dart';
import 'package:househunt/controllers/flat_form_controller.dart';
import 'package:househunt/models/asset_models.dart';
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
                              file: element.file,
                              isVideo: element.type == 'video',
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
                        (e) => FileAsset(file: File(e.file.path), type: e.type),
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

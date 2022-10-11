import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/pg_form_controller.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:househunt/widgets/asset_picker.dart';
import 'package:househunt/Forms/pg_form.dart';
import 'package:househunt/widgets/asset_thumb.dart';

class PgHome extends StatelessWidget {
  PgHome({Key? key}) : super(key: key);

  final PgFormController pgFormController = Get.put(PgFormController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: false,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        foregroundColor: primary,
        title: Text(
          "Paying Guest",
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
                      children: pgFormController.assets
                          .map(
                            (el) => AssetThumb(
                                onRemove: () {
                                  pgFormController.assets.remove(el);
                                },
                                file: el),
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
                    pgFormController.assets.addAll(
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
          const PgForm(),
        ],
      ),
    );
  }
}

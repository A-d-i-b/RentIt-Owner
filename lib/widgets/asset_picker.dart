import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class AssetPickerWidget extends StatefulWidget {
  const AssetPickerWidget({Key? key}) : super(key: key);

  @override
  State<AssetPickerWidget> createState() => _AssetPickerWidgetState();
}

class _AssetPickerWidgetState extends State<AssetPickerWidget> {
  List<AssetEntity>? _assets;

  @override
  Widget build(BuildContext context) {
    return Column(
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
          child: Row(
            children: [
              if (_assets != null)
                ..._assets!.map(
                  (asset) => Row(
                    children: [
                      AssetThumb(
                        asset: asset,
                        width: 100,
                        height: 100,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        // pick assets
        ElevatedButton(
          onPressed: () async {
            final List<AssetEntity>? assets = await AssetPicker.pickAssets(
              context,
              pickerConfig: const AssetPickerConfig(
                maxAssets: 10,
              ),
            );
            setState(() {
              _assets = assets;
            });
          },
          child: const Text('Pick Assets'),
        ),
      ],
    );
  }
}

class AssetThumb extends StatelessWidget {
  const AssetThumb({
    Key? key,
    required this.asset,
    required this.width,
    required this.height,
  }) : super(key: key);

  final AssetEntity asset;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: FutureBuilder(
        future: asset.file,
        builder: (context, snapshot) => snapshot.hasData
            ? Image.file(
                snapshot.data as File,
                fit: BoxFit.cover,
              )
            : // tween animation container loading
            Container(
                color: Colors.grey,
              ),
      ),
    );
  }
}


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
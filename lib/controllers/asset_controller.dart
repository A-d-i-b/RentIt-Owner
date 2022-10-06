import 'dart:io';
import 'package:get/get.dart';

class AssetController extends GetxController {
// set
  RxSet<String> assetSet = <String>{}.obs;

  void addAsset(File asset) {
    assetSet.add(asset.path);
  }

  void removeAsset(File asset) {
    assetSet.remove(asset);
  }

  void addAssets(List<File> assets) {
    assetSet.addAll(assets.map((e) => e.path));
  }
}

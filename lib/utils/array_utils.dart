import 'package:househunt/models/asset_models.dart';

bool imageExists(List<FileAsset> assets, List? itemsFromFirebase) {
  for (final asset in assets) {
    if (asset.type == AssetType.photo) {
      return true;
    }
  }
  if (itemsFromFirebase != null) {
    for (final item in itemsFromFirebase) {
      if (item['type'] == 'photo') {
        return true;
      }
    }
  }

  return false;
}

bool itemsChanged(List originalItemsFromFirebase, List itemsFromFirebase) {
  if (originalItemsFromFirebase.length != itemsFromFirebase.length) {
    return true;
  }
  for (int i = 0; i < itemsFromFirebase.length; i++) {
    if (originalItemsFromFirebase[i]['Url'] != itemsFromFirebase[i]['Url']) {
      return true;
    }
  }
  return false;
}

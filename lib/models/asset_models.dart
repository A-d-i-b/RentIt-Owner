import 'dart:io';

enum AssetType { photo, video }

class FileAsset {
  File file;
  AssetType type;

  FileAsset({required this.file, required this.type});
}

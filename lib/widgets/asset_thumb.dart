import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';



class AssetThumb extends StatelessWidget {
  AssetThumb({
    Key? key,
    required this.onRemove,
    required this.file,
    // this.isVideo = false,
    this.newAsset = false,
    this.videoThumb,
  }) : super(key: key);

  final VoidCallback onRemove;
  final ImageProvider file;
  // final bool isVideo;
  final bool newAsset;
  Future<String?>? videoThumb = Future.value();

  // UrlType getUrlType(String url) {
  //   Uri uri = Uri.parse(url);
  //   String typeString = uri.path.substring(uri.path.length - 3).toLowerCase();
  //   if (typeString == "jpg") {
  //     return UrlType.IMAGE;
  //   }
  //   if (typeString == "mp4") {
  //     return UrlType.VIDEO;
  //   } else {
  //     return UrlType.UNKNOWN;
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Stack(
      // allow overflow
      clipBehavior: Clip.none,
      children: [
        (videoThumb != null)
            ? FutureBuilder<String?>(
                future: videoThumb,
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return const SizedBox(
                      height: 100,
                      width: 100,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }

                  return Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      image: DecorationImage(
                        image: FileImage(
                          File(snapshot.data!),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                })
            : Container(
                width: 100,
                height: 100,
                margin: const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: file,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
        if (videoThumb != null)
          Positioned(
            bottom: 5,
            right: 15,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
                size: 15,
              ),
            ),
          ),
        if (newAsset)
          Positioned(
            top: 5,
            left: 5,
            child: Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.5),
                borderRadius: BorderRadius.circular(5),
              ),
              child: Text(
                'New',
                style: Get.textTheme.button!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        Positioned(
          top: -10,
          right: 0,
          child: Container(
            width: 25,
            height: 25,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  offset: const Offset(3, 3),
                  spreadRadius: -3,
                  blurRadius: 10,
                  color: Colors.grey[400]!,
                )
              ],
            ),
            child: Center(
              child: IconButton(
                onPressed: onRemove,
                icon: const Icon(Icons.close),
                color: Colors.redAccent,
                iconSize: 20,
                padding: const EdgeInsets.all(0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

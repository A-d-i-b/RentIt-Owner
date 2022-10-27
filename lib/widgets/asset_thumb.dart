import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AssetThumb extends StatelessWidget {
  const AssetThumb({
    Key? key,
    required this.onRemove,
    required this.file,
    this.isVideo = false,
    this.newAsset = false,
  }) : super(key: key);

  final VoidCallback onRemove;
  final ImageProvider file;
  final bool isVideo;
  final bool newAsset;
  @override
  Widget build(BuildContext context) {
    return Stack(
      // allow overflow
      clipBehavior: Clip.none,
      children: [
        Container(
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
        if (isVideo)
          Positioned(
            top: 5,
            right: 5,
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

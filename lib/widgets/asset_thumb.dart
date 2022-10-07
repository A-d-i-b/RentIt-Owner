import 'dart:io';

import 'package:flutter/material.dart';

class AssetThumb extends StatelessWidget {
  const AssetThumb({Key? key, required this.onRemove, required this.file})
      : super(key: key);

  final VoidCallback onRemove;
  final File file;

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
              image: FileImage(file),
            ),
            borderRadius: BorderRadius.circular(10),
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

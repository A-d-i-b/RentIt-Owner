import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/firebase_controller.dart';

class PropertyCard extends StatelessWidget {
  final FireBaseController fireBaseController = Get.put(FireBaseController());
  PropertyCard(
      {Key? key,
      required this.name,
      required this.id,
      required this.description,
      required this.onTap})
      : super(key: key);

  final String name;
  final int? id;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Id:-$id",
                  style: const TextStyle(fontSize: 20, color: Colors.black54),
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: Get.width / 2.5,
                  width: Get.width / 2,
                  child: FireBaseController.display(id!),
                ),
                const SizedBox(height: 8),
                ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: Get.width / 2.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: Get.textTheme.headline6,
                      ),
                      Text(
                        description,
                        style: Get.textTheme.bodyLarge,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 8),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

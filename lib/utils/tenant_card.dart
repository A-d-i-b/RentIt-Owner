import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TenantCard extends StatefulWidget {
  final ImageProvider image;
  final String name;
  final String pgname;
  final VoidCallback onTap;

  const TenantCard({
    Key? key,
    required this.image,
    required this.name,
    required this.pgname,
    required this.onTap,
  }) : super(key: key);

  @override
  State<TenantCard> createState() => _TenantCardState(
      // image: image,
      // name: name,
      // pgname: pgname,
      );
}

class _TenantCardState extends State<TenantCard> {
  // final ImageProvider image;
  // final String name;
  // final String pgname;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: Colors.black,
            width: 0.5,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: widget.image,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Colors.pinkAccent,
              ),
            ),
            const SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tenant Name", style: Get.textTheme.headline6),
                const Text(
                  "Pg Name",
                  style: TextStyle(fontSize: 13, color: Colors.black),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

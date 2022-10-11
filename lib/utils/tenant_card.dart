import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TenantCard extends StatefulWidget {
  final ImageProvider image;
  final String name;
  final String pgName;
  final VoidCallback onTap;

  const TenantCard({
    Key? key,
    required this.image,
    required this.name,
    required this.pgName,
    required this.onTap,
  }) : super(key: key);

  @override
  State<TenantCard> createState() => _TenantCardState();
}

class _TenantCardState extends State<TenantCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        elevation: 2,
        child: Container(
          padding: const EdgeInsets.all(10),
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
                width: 100,
                height: 100,
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
                  Text(
                    "Tenant Name",
                    style: Get.textTheme.headline6,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const Text(
                    "Pg Name",
                    style: TextStyle(fontSize: 13, color: Colors.black),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

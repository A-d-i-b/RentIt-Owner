import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TenantCard extends StatefulWidget {
  final ImageProvider image;
  final String name;
  final String pgname;

  TenantCard({
    Key? key,
    required this.image,
    required this.name,
    required this.pgname,
  }) : super(key: key);

  @override
  State<TenantCard> createState() => _TenantCardState(
        image: this.image,
        name: this.name,
        pgname: this.pgname,
      );
}

class _TenantCardState extends State<TenantCard> {
  final ImageProvider image;
  final String name;
  final String pgname;

  _TenantCardState({
    required this.image,
    required this.name,
    required this.pgname,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.all(20),
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
                  image: image,
                ),
                borderRadius: BorderRadius.circular(10),
                color: Colors.pinkAccent,
              ),
            ),
            SizedBox(width: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Tenant Name", style: Get.textTheme.headline6),
                Text(
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

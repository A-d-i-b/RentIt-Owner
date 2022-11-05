import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/utils/details_card.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ContactUs extends StatefulWidget {
  const ContactUs({Key? key}) : super(key: key);

  @override
  State<ContactUs> createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Color(0xFF654BD8)),
        centerTitle: true,
        elevation: 0.0,
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        title: Text(
          "Contact Us",
          style: Get.textTheme.headline4,
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(30),
        children: [
          Text("You Can Contact Us On", style: Get.textTheme.headline5),
          const SizedBox(height: 44),
          DetailCard(
            detail: "8287382403",
            icon: Icons.phone,
            ontap: () {
              launchUrlString("tel:+918287382403");
            },
          ),
          const SizedBox(height: 20),
          DetailCard(
            detail: "7820013159",
            icon: Icons.phone,
            ontap: () {
              launchUrlString("tel:+917820013159");
            },
          ),
          const SizedBox(height: 20),
          DetailCard(
            detail: "8827564943",
            icon: Icons.phone,
            ontap: () {
              launchUrlString("tel:+918827564943");
            },
          ),
          const SizedBox(height: 30),
          Text("Also you can mail your query to us on",
              style: Get.textTheme.headline5),
          const SizedBox(height: 40),
          DetailCard(
            detail: "rentit6388@gmail.com",
            icon: Icons.email,
            ontap: () {
              launchUrlString(
                  "mailto:rentit6388@gmail.com?subject=${Uri.encodeFull("")}&body=${Uri.encodeFull("")}");
            },
          ),
        ],
      ),
    );
  }
}

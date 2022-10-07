import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/utils/details_card.dart';

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
        padding: EdgeInsets.all(30),
        children: [
          Text("You Can Contact Us On", style: Get.textTheme.headline5),
          const SizedBox(height: 44),
          DetailCard(detail: "8287382403", icon: Icons.phone),
          SizedBox(height: 20),
          DetailCard(detail: "8708558486", icon: Icons.phone),
          SizedBox(
            height: 20,
          ),
          DetailCard(detail: "8827564943", icon: Icons.phone),
          SizedBox(
            height: 20,
          ),
          DetailCard(detail: "9871010603", icon: Icons.phone),
          SizedBox(
            height: 20,
          ),
          DetailCard(detail: "8860397569", icon: Icons.phone),
          SizedBox(height: 30),
          Text("Also you can mail your query to us on",
              style: Get.textTheme.headline5),
          SizedBox(height: 40),
          DetailCard(detail: "dreamcrushers@gmail.com", icon: Icons.email),
        ],
      ),
    );
  }
}

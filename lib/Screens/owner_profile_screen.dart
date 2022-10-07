import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:househunt/utils/details_card.dart';

class OwnerProfile extends StatefulWidget {
  const OwnerProfile({Key? key}) : super(key: key);

  @override
  State<OwnerProfile> createState() => _OwnerProfileState();
}

class _OwnerProfileState extends State<OwnerProfile> {
  ImageProvider profileImage = AssetImage('images/ownerpic.jpg');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        title: Text(
          "My Account",
          style: Get.textTheme.headline4,
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(30),
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: profileImage,
              ),
              SizedBox(width: 20),
              Column(
                children: [
                  Text(
                    "Owner Name",
                    style: TextStyle(fontSize: 19, color: secondary),
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 20,
                    width: MediaQuery.of(context).size.width / 2.7,
                    child: ElevatedButton(
                      onPressed: () {
                        null; //TODO:Add image picker function and store it in profileImage variable
                      },
                      child: Text(
                        "Upload Image",
                        style: TextStyle(color: tri),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 50),
          DetailCard(
              detail: "8348932668",
              icon: Icons
                  .phone), //TODO:Fetch actual phone number of owner and pass it here
          const SizedBox(height: 30),
          DetailCard(
              detail: "Owner Address",
              icon: Icons
                  .fmd_good_sharp), //TODO:Fetch actual Address of owner and pass it here
          const SizedBox(height: 30),
          DetailCard(
              detail: "Owner Email",
              icon: Icons
                  .email), //TODO:Fetch actual Email of owner and pass it here
          SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {},
            child: Text(
              "Edit",
              style: TextStyle(color: tri, fontSize: 20),
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/contact-screen');
            },
            child: Text(
              "Contact Us",
              style: TextStyle(color: tri, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}

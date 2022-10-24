import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/firebase_controller.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:househunt/utils/details_card.dart';

class OwnerProfile extends StatefulWidget {
  OwnerProfile({Key? key}) : super(key: key);

  @override
  State<OwnerProfile> createState() => _OwnerProfileState();
}

class _OwnerProfileState extends State<OwnerProfile> {
  final UserController userController = Get.put(UserController());

  final FireBaseController fireBaseController = Get.put(FireBaseController());

  Future getUrl() async {
    String data2 = '';
    await FirebaseFirestore.instance
        .collection('users')
        .doc('${userController.user.value.id}')
        .get()
        .then((DocumentSnapshot doc) {
      data2 = (doc.data() as Map<String, dynamic>)['Url'];
    });
    print(data2);
    userController.image.value = data2;
  }

  @override
  Widget build(BuildContext context) {
    final profileImage = Image.asset('images/ownerpic.jpg', fit: BoxFit.cover);
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
        padding: const EdgeInsets.all(30),
        children: [
          Column(
            children: [
              Container(
                // radius: 60,
                // backgroundImage: profileImage.image,
                width: Get.width / 2,
                height: Get.width / 2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(120),
                  image: DecorationImage(
                    image: userController.image.value != ''
                        ? NetworkImage(userController.image.value)
                        : profileImage.image,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Obx(
                () => Text(
                  userController.user.value.name,
                  style: Get.textTheme.headline5!.copyWith(
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.2,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              ),
            ],
          ),
          const SizedBox(height: 50),
          Obx(
            () => DetailCard(
              detail: userController.user.value.phone,
              icon: Icons.phone,
            ),
          ),
          const SizedBox(height: 30),
          // Obx(
          //   () => DetailCard(
          //     detail: userController.user.value.address,
          //     icon: Icons.fmd_good_sharp,
          //   ),
          // ),
          // const SizedBox(height: 50),
          ElevatedButton(
            onPressed: () {
              Get.toNamed('/update');
            },
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Edit",
                style: TextStyle(color: tri, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // Get.toNamed('/example');
              // getUrl();
              print(userController.image.value);
              Get.toNamed('/contact-screen');
            },
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Contact Us",
                style: TextStyle(color: tri, fontSize: 20),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              // print(FirebaseFirestore.instance.collection(collectionPath))
              Get.offAllNamed('/sign-in');
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.red[600],
            ),
            child: const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                "Log Out",
                style: TextStyle(color: tri, fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

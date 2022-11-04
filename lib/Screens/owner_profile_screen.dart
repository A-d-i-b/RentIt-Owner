import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/firebase_controller.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:househunt/utils/details_card.dart';

class OwnerProfile extends StatefulWidget {
  const OwnerProfile({Key? key}) : super(key: key);

  @override
  State<OwnerProfile> createState() => _OwnerProfileState();
}

class _OwnerProfileState extends State<OwnerProfile> {
  final UserController userController = Get.put(UserController());

  final FireBaseController fireBaseController = Get.put(FireBaseController());

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
              Obx(
                () => Container(
                  width: Get.width / 2,
                  height: Get.width / 2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(120),
                  ),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(120),
                      child: userController.image.value != ''
                          ? CachedNetworkImage(
                              imageUrl: userController.image.value,
                              fit: BoxFit.cover,
                              placeholder: (context, url) => const SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: CircularProgressIndicator(),
                              ),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            )
                          : profileImage),
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
              Get.toNamed('/contact-screen');
              // getUrl();
              // Get.toNamed('/contact-screen');
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
              userController.signOut();
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

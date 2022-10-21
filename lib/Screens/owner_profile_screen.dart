import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/theme/base_theme.dart';
import 'package:househunt/utils/details_card.dart';

class OwnerProfile extends StatelessWidget {
  OwnerProfile({Key? key}) : super(key: key);

  final UserController userController = Get.put(UserController());

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
                  // radius: 60,
                  // backgroundImage: profileImage.image,
                  width: Get.width / 2,
                  height: Get.width / 2,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: profileImage.image,
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(120),
                    child: userController.user.value.imageUrl != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: CachedNetworkImage(
                              imageUrl: userController.user.value.imageUrl!,
                              placeholder: (context, url) => const Center(
                                child: CircularProgressIndicator(),
                              ),
                              fit: BoxFit.cover,
                            ),
                          )
                        : null,
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

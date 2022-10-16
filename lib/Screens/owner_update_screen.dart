import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/theme/base_theme.dart';

class OwnerUpdate extends StatefulWidget {
  const OwnerUpdate({Key? key}) : super(key: key);

  @override
  State<OwnerUpdate> createState() => _OwnerUpdateState();
}

class _OwnerUpdateState extends State<OwnerUpdate> {
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    final profileImage = Image.asset('images/ownerpic.jpg',
        fit: BoxFit
            .cover); //TODO: Update this pic using image picker also update to the database
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
                () => SizedBox(
                  width: Get.width / 2,
                  child: TextField(
                    onChanged: (val) {
                      //TODO:change the value of name
                    },
                    controller: TextEditingController(
                        text: userController.user.value.name),
                    decoration: const InputDecoration(
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: primary,
                          ),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: primary,
                          ),
                        ),
                        errorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        focusedErrorBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.red,
                          ),
                        ),
                        labelText: 'Name'),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
              height: Get.height / 16,
              child: ElevatedButton(
                  onPressed: () {}, child: const Text("Upload Photo"))),
          const SizedBox(height: 30),
          Obx(
            () => TextField(
              onChanged: (val) {
                //TODO:change the value of name
              },
              controller:
                  TextEditingController(text: userController.user.value.phone),
              decoration: const InputDecoration(
                  prefixIcon: Padding(
                      padding: EdgeInsets.all(20), child: Icon(Icons.phone)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primary,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primary,
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  labelText: 'Phone No.'),
            ),
          ),
          const SizedBox(height: 20),
          Obx(
            () => TextField(
              maxLines: 4,
              onChanged: (val) {
                //TODO:change the value of name
              },
              controller: TextEditingController(
                  text: userController.user.value.address),
              decoration: const InputDecoration(
                  prefixIcon: Padding(
                      padding: EdgeInsets.all(20),
                      child: Icon(Icons.fmd_good_sharp)),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primary,
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: primary,
                    ),
                  ),
                  errorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  focusedErrorBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.red,
                    ),
                  ),
                  labelText: 'Address'),
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: Get.height / 16,
            child: ElevatedButton(
              child: const Text("Update"),
              onPressed: () {
                //TODO:
              },
            ),
          ),
        ],
      ),
    );
  }
}

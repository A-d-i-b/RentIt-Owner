import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/flat_form_controller.dart';
import 'package:househunt/controllers/pg_form_controller.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/widgets/property_card.dart';

class LandingHomeScreen extends StatelessWidget {
  LandingHomeScreen({Key? key}) : super(key: key);

  final PgFormController pgFormController = Get.put(PgFormController());
  final FlatFormController flatFormController = Get.put(FlatFormController());
  final UserController userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Obx(
                  () => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hey there,',
                        style: Get.textTheme.headline4!.copyWith(
                          color: Get.theme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        userController.user.value.name,
                        style: Get.textTheme.displaySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                Text('Your properties', style: Get.textTheme.headline6),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Obx(
                    () => Text(
                      'PG (${pgFormController.pgs.length})',
                      style: Get.textTheme.labelLarge!.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: pgFormController.pgs
                          .map(
                            (pg) => PropertyCard(
                              name: pg.pgName,
                              description: pg.description,
                              onTap: () {
                                Get.toNamed('/add-pg', arguments: {
                                  'pgFormModel': pg,
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Obx(
                    () => Text(
                      'FLATS (${flatFormController.flats.length})',
                      style: Get.textTheme.labelLarge!.copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Obx(
                    () => Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: flatFormController.flats
                          .map(
                            (flat) => PropertyCard(
                              name: flat.flatName,
                              description: flat.description,
                              onTap: () {
                                Get.toNamed('/add-flat', arguments: {
                                  'flatFormModel': flat,
                                });
                              },
                            ),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
                Text('Add properties', style: Get.textTheme.headline6),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/add-pg');
                      },
                      child: SizedBox(
                        height: Get.width / 3,
                        width: Get.width / 3,
                        child: Center(
                          child: Text(
                            'PG',
                            style: Get.textTheme.headline4!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Get.toNamed('/add-flat');
                      },
                      child: SizedBox(
                        width: Get.width / 3,
                        height: Get.width / 3,
                        child: Center(
                          child: Text(
                            'FLAT',
                            style: Get.textTheme.headline4!.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

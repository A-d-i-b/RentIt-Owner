import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/flat_form_controller.dart';
import 'package:househunt/controllers/pg_form_controller.dart';
import 'package:househunt/widgets/property_card.dart';

class LandingHomeScreen extends StatelessWidget {
  LandingHomeScreen({Key? key}) : super(key: key);

  final PgFormController pgFormController = Get.put(PgFormController());
  final FlatFormController flatFormController = Get.put(FlatFormController());

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
                Column(
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
                      //TODO: Get user name
                      'Michael',
                      style: Get.textTheme.displaySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 35),
                Text('Your properties', style: Get.textTheme.headline6),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'PG (${pgFormController.pgs.length})',
                    style: Get.textTheme.labelLarge!.copyWith(
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
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
                                name: pg.pgName, description: pg.description),
                          )
                          .toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: Text(
                    'FLATS (${flatFormController.flats.length})',
                    style: Get.textTheme.labelLarge!.copyWith(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
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
                                description: flat.description),
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
                    const SizedBox(width: 16),
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

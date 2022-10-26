import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/controllers/flat_form_controller.dart';
import 'package:househunt/controllers/pg_form_controller.dart';
import 'package:househunt/controllers/user_controller.dart';
import 'package:househunt/models/flat_form_model.dart';
import 'package:househunt/models/pg_form_model.dart';
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
                        userController.user.value.firstName,
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
                  child: pgFormController.obx(
                    (state) => Text(
                      'PG (${state!.length})',
                      style: Get.textTheme.labelLarge!.copyWith(
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onLoading: null,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: pgFormController.obx(
                    (state) {
                      return Row(
                        children: state!
                            .map(
                              (e) => PropertyCard(
                                description: e.description,
                                id: e.id,
                                name: e.pgName,
                                onTap: () {
                                  pgFormController.pgFormModel.value =
                                      PgFormModel.from(e);

                                  pgFormController.updateTextFields(e, 'pg');
                                  pgFormController.updateDropdowns(e);
                                  pgFormController.updateRoomRents(e);
                                  pgFormController.updateRentFields(e);
                                  Get.toNamed('/add-pg', arguments: {
                                    'pgFormModel': e,
                                  });
                                },
                              ),
                            )
                            .toList(),
                      );
                    },
                    onEmpty: const Center(child: Text('No PGs found')),
                  ),
                ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: flatFormController.obx(
                    (data) => Text(
                      'FLATS (${data!.length})',
                      style: Get.textTheme.labelLarge!.copyWith(
                        color: Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onLoading: null,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: flatFormController.obx(
                    (data) {
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: data!
                            .map(
                              (e) => PropertyCard(
                                id: e.id,
                                description: e.description,
                                name: e.flatName,
                                onTap: () {
                                  flatFormController.flatFormModel.value =
                                      FlatFormModel.from(e);

                                  flatFormController.updateTextFields(
                                      e, 'flat');
                                  flatFormController.updateDropdowns(e);
                                  Get.toNamed('/add-flat', arguments: {
                                    'flatFormModel': e,
                                  });
                                },
                              ),
                            )
                            .toList(),
                      );
                    },
                    onEmpty: const Center(child: Text('No Flats found')),
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
                        pgFormController.clearTextControllers();
                        pgFormController.clearRoomRents();
                        pgFormController.clearDropdowns();

                        pgFormController.assets.clear();

                        pgFormController.pgFormModel.value = PgFormModel(
                          pgName: '',
                          address: '',
                          description: '',
                        );

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
                        flatFormController.clearTextControllers();
                        flatFormController.clearDropdowns();

                        flatFormController.assets.clear();

                        flatFormController.flatFormModel.value = FlatFormModel(
                          flatName: '',
                          address: '',
                          description: '',
                        );
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

// pgFormController.pgs.map(
//                         (pg) {
//                           return PropertyCard(
//                             name: pg.pgName,
//                             description: pg.description,
//                             onTap: () {
// Get.toNamed('/add-pg', arguments: {
//   'pgFormModel': pg,
// });
//                             },
//                           );
//                         },
//                       ).toList(),

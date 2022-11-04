import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/utils/tenant_card.dart';

class TenantList extends StatefulWidget {
  const TenantList({Key? key}) : super(key: key);

  @override
  State<TenantList> createState() => _TenantListState();
}

class _TenantListState extends State<TenantList> {
  List<Widget> cards = [
    TenantCard(
      image: const AssetImage(
          'images/tenantexample.jpeg'), //TODO:Fetch Actual, image name and pg name
      name: "Tenant Name",
      pgName: "Pg name",
      onTap: () {
        // Get.toNamed('/tenant-profile', arguments: {
        //   "TenantImage": const AssetImage(
        //       "images/tenantexample.jpeg"), //TODO:Pass Actual Parameters
        //   "TenantName": "Tenant Name",
        //   "PhoneNumber": "8862732723",
        //   "PgName": "Pg/flat Name",
        //   "Address": "Tenant Address",
        // });
      },
    ),
    TenantCard(
      image: const AssetImage('images/tenantexample.jpeg'),
      name: "Tenant Name",
      pgName: "Pg name",
      onTap: () {
        // Get.toNamed('/tenant-profile', arguments: {
        //   "TenantImage": const AssetImage("images/tenantexample.jpeg"),
        //   "TenantName": "Tenant Name",
        //   "PhoneNumber": "8862732723",
        //   "PgName": "Pg/flat Name",
        //   "Address": "Tenant Address",
        // });
      },
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        title: Text(
          "Tenants",
          style: Get.textTheme.headline4,
        ),
      ),
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: ListView.separated(
            itemCount: cards.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: cards[index],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(height: 10);
            },
          ),
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: SizedBox(
            width: Get.width,
            height: Get.height,
            child: const Center(
                child: Text(
              "Coming Soon",
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
            )),
          ),
        )
      ]),
    );
  }
}

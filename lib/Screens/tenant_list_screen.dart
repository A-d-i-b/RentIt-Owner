import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:househunt/utils/tenant_card.dart';

class TenantList extends StatefulWidget {
  const TenantList({Key? key}) : super(key: key);

  @override
  State<TenantList> createState() => _TenantListState();
}

class _TenantListState extends State<TenantList> {
  List<Widget> Cards = [
    TenantCard(
      image: const AssetImage(
          'images/tenantexample.jpeg'), //TODO:Fetch Actual, image name and pg name
      name: "Tenant Name",
      pgname: "Pg name",
      onTap: () {
        Get.toNamed('/tenant-profile', arguments: {
          "TenantImage": const AssetImage("images/tenantexample.jpeg"),
          "TenantName": "Tenant Name",
          "PhoneNumber": "8862732723",
          "PgName": "Pg/flat Name",
          "Address": "Tenant Address",
        });
      },
    ),
    TenantCard(
      image: const AssetImage('images/tenantexample.jpeg'),
      name: "Tenant Name",
      pgname: "Pg name",
      onTap: () {
        Get.toNamed('/tenant-profile', arguments: {
          "TenantImage": const AssetImage("images/tenantexample.jpeg"),
          "TenantName": "Tenant Name",
          "PhoneNumber": "8862732723",
          "PgName": "Pg/flat Name",
          "Address": "Tenant Address",
        });
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
      body: ListView.builder(
        itemCount: Cards.length,
        itemBuilder: (BuildContext context, int index) {
          return Cards[index];
        },
      ),
    );
  }
}

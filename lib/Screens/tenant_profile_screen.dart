import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/utils/child_card.dart';
import 'package:househunt/utils/reusable_card.dart';

class TenantProfile extends StatefulWidget {
  const TenantProfile({Key? key}) : super(key: key);

  @override
  State<TenantProfile> createState() => _TenantProfileState();
}

class _TenantProfileState extends State<TenantProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0.0,
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        title: Text(
          "Tenant",
          style: Get.textTheme.headline4,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView(
          children: [
            const Center(
              //TODO:Remove const when Fetching Image from API
              child: CircleAvatar(
                radius: 82,
                backgroundImage: AssetImage(
                  "images/tenantexample.jpeg",
                ), //TODO:Change to tenant image
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: Text(
                  "Tenant Name", //TODO:Enter tenant name
                  style: Get.textTheme.headline5,
                ),
              ),
            ),
            const SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: const [
                  ReusableCard(
                    color: Colors.blueAccent,
                    childCard: ClmCard(
                      cusIcon: Icons.phone,
                      a: "TenantNumber",
                    ),
                  ),
                  SizedBox(height: 20),
                  ReusableCard(
                    color: Colors.blueAccent,
                    childCard: ClmCard(
                      cusIcon: Icons.fmd_good_sharp,
                      a: "Address", //TODO:Enter tenant address
                    ),
                  ),
                  SizedBox(height: 20),
                  ReusableCard(
                    color: Colors.blueAccent,
                    childCard: ClmCard(
                      cusIcon: Icons.apartment,
                      a: "Pg/Flat Name", //TODO:Enter Pg/flat actual name
                    ),
                  ),
                ],
              ),
            ), //TODO:Enter actuall tenant number
          ],
        ),
      ),
    );
  }
}

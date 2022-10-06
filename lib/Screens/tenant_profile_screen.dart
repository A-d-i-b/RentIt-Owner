import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:househunt/utils/reusable_card.dart';
import 'package:househunt/utils/child_card.dart';

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
        padding: EdgeInsets.all(20),
        child: ListView(
          children: [
            const Center(
              //TODO:Remove const when Fetching Image from API
              child: CircleAvatar(
                backgroundColor: Colors.blueAccent,
                radius: 82,
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage(
                      "images/tenantexample.jpeg"), //TODO:Change to tenant image
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20),
              child: Center(
                child: Text(
                  "Tenant Name", //TODO:Enter tenant name
                  style: Get.textTheme.headline5,
                ),
              ),
            ),
            SizedBox(height: 30),
            Reusablecard(
                colour: Colors.blueAccent,
                childcard: Clmcard(
                    cusicon: Icons.phone,
                    a: "TenantNumber")), //TODO:Enter actuall tenant number
            Reusablecard(
                colour: Colors.blueAccent,
                childcard: Clmcard(
                  cusicon: Icons.fmd_good_sharp,
                  a: "Address", //TODO:Enter tenant address
                )),
            Reusablecard(
                colour: Colors.blueAccent,
                childcard: Clmcard(
                  cusicon: Icons.apartment,
                  a: "Pg/Flat Name", //TODO:Enter Pg/flat actual name
                )),
          ],
        ),
      ),
    );
  }
}

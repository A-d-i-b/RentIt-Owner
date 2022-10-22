import 'package:flutter/material.dart';
import 'package:househunt/controllers/firebase_controller.dart';
import 'package:get/get.dart';

class Example extends StatefulWidget {
  const Example({Key? key}) : super(key: key);

  @override
  State<Example> createState() => ExampleState();
}

class ExampleState extends State<Example> {
  final FireBaseController fireBaseController = Get.put(FireBaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(itemBuilder: (BuildContext context, int index) {
        return Container(
          height: 200,
          width: 200,
          decoration:
              BoxDecoration(image: DecorationImage(image: NetworkImage(''))),
        );
      }),
    );
  }
}

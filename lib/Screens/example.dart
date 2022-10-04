import 'package:flutter/material.dart';
import 'package:househunt/Screens/pg.dart';

class Example extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text("press"),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Pghome()));
          },
        ),
      ),
    );
  }
}

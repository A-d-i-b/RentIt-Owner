import 'package:flutter/material.dart';
import 'package:househunt/Screens/pg_screen.dart';

class Example extends StatelessWidget {
  const Example({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: const Text("press"),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PgHome()));
          },
        ),
      ),
    );
  }
}

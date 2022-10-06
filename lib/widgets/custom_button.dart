import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, required this.type, required this.onPressed})
      : super(key: key);

  final String type;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 2.5,
          height: 70,
          child: Card(
            color: const Color(0xFF0EB7B7),
            elevation: 5,
            child: Center(
              child: Text(
                type,
                style: const TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
        const Spacer(),
        Baseline(
          baseline: 37,
          baselineType: TextBaseline.alphabetic,
          child: SizedBox(
            width: MediaQuery.of(context).size.width / 2.5,
            height: MediaQuery.of(context).size.height / 13,
            child: TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter the amount",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide:
                      const BorderSide(color: Color(0xFF0EB7B7), width: 1),
                ),
              ),
              onChanged: (value) {
                onPressed(value);
              },
            ),
          ),
        ),
      ],
    );
  }
}

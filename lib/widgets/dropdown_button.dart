import 'package:flutter/material.dart';

class DropDownButton extends StatelessWidget {
  const DropDownButton({
    Key? key,
    required this.name,
    required this.items,
    required this.onChange,
    required this.value,
  }) : super(key: key);

  final String name;
  final List<DropdownMenuItem<String>> items;
  final Function onChange;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(name),
        const SizedBox(height: 6),
        Container(
          width: MediaQuery.of(context).size.width / 2.5,
          height: 50,
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: const Color(0xFF0EB7B7),
                width: 1,
              )),
          child: SizedBox(
            child: DropdownButton(
                isExpanded: true,
                underline: Container(),
                // value: Details[name],
                value: value,
                items: items,
                onChanged: (value) {
                  onChange(value);
                }),
          ),
        )
      ],
    );
  }
}

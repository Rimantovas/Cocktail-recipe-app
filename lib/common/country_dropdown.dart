import 'package:flutter/material.dart';

class CountryDropdown extends StatelessWidget {
  final List<String> names;
  final String name;
  final void Function(String?) onChanged;

  const CountryDropdown({
    required this.names,
    required this.name,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      height: 40.0,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: name,
          items: names
              .map((e) => DropdownMenuItem(
                    alignment: Alignment.center,
                    enabled: e != "" ? true : false,
                    child: Text(
                      e,
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    value: e,
                  ))
              .toList(),
          onChanged: onChanged,
        ),
      ),
    );
  }
}

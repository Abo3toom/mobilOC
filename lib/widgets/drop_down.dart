import 'package:flutter/material.dart';

Widget customDropDown(List<String> items, String value, void onChange(val)) {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 18),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(8),
    ),
    child: DropdownButton<String>(
      value: value,
      onChanged: (val) {
        onChange(val);
      },
      items: items?.map((String val) {
            return DropdownMenuItem(
                child: Text(
                  val,
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
                value: val);
          })?.toList() ??
          [],
    ),
  );
}

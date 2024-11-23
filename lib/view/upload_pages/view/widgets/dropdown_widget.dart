import 'package:flutter/material.dart';
import 'package:jora_customer/Settings/until/PColors.dart';

class DropdownWidgetUi extends StatefulWidget {
  const DropdownWidgetUi({super.key});

  @override
  State<DropdownWidgetUi> createState() => _DropdownWidgetUiState();
}

class _DropdownWidgetUiState extends State<DropdownWidgetUi> {
  String value = "Anyone";
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.0,
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          isDense: true,
          dropdownColor: PColors.black2,
          value: value,
          // isExpanded: true,
          style: TextStyle(color: PColors.whiteOff),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: PColors.whiteOff,
          ),
          underline: SizedBox(),
          items: <String>['Anyone', 'Nobody'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(color: PColors.whiteOff),
              ),
            );
          }).toList(),
          onChanged: (val) {
            setState(() {
              value = val!;
            });
          },
        ),
      ),
    );
  }
}

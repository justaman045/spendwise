import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionCheckBox extends StatelessWidget {
  const OptionCheckBox(
      {super.key,
        required this.stringLabel,
        required this.dataValue,
        required this.function});

  final String stringLabel;
  final bool dataValue;
  final Function function;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 30.r,
        right: 20.w,
      ),
      child: Row(
        children: [
          Checkbox(
            value: dataValue,
            onChanged: (bool? value) {
              function(value);
            },
          ),
          SizedBox(
            width: 250.w,
            child: Text(stringLabel),
          )
        ],
      ),
    );
  }
}
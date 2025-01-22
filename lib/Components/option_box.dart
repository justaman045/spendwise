import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OptionBox extends StatelessWidget {
  const OptionBox({
    super.key,
    required this.function,
    required this.labelString,
    required this.items,
  });

  final Function function;
  final String labelString;
  final List<DropdownMenuItem<String>> items;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.r,
        top: 15.h,
        right: 20.w,
      ),
      child: SizedBox(
        height: 48.h,
        child: DropdownButtonFormField(
          decoration: InputDecoration(
            label: Text(
              labelString,
              style: TextStyle(
                fontSize: 13.r,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.h),
            ),
          ),
          items: items,
          onChanged: (String? value) => function(value),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextBox extends StatelessWidget {
  const TextBox({
    super.key,
    required this.controller,
    required this.formatter,
    required this.function,
    required this.labelString,
    this.readOnly = false,
  });

  final TextEditingController controller;
  final List<FilteringTextInputFormatter> formatter;
  final Function function;
  final String labelString;
  final bool readOnly;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 20.r,
        top: 15.h,
        right: 20.w,
      ),
      child: SizedBox(
        height: 50.h,
        child: TextFormField(
          controller: controller,
          inputFormatters: formatter,
          validator: (value) => function(value),
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
          readOnly: readOnly,
        ),
      ),
    );
  }
}
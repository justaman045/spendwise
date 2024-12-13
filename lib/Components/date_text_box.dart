import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

class DateField extends StatelessWidget {
  const DateField({super.key, required this.dateController});

  final TextEditingController dateController;

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
        child: TextFormField(
          canRequestFocus: false,
          keyboardType: TextInputType.none,
          controller: dateController,
          decoration: InputDecoration(
            suffixIcon: IconButton(
              icon: const Icon(Icons.calendar_month_rounded),
              onPressed: () async {
                dynamic date = await showDatePicker(
                    context: context,
                    firstDate:
                    DateTime(DateTime.now().year - 1),
                    lastDate: DateTime(2099));
                dateController.text =
                    DateFormat.yMMMMd().format(date);
              },
            ),
            label: const Text("Transaction Date"),
            hintText: dateController.text,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
      ),
    );
  }
}
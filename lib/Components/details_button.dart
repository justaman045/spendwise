import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

class DetailsButton extends StatelessWidget {
  const DetailsButton({
    super.key,
    required this.width,
    required this.btnText,
    required this.icon,
    required this.ontapFunc,
  });

  final double width;
  final String btnText;
  final Icon icon;
  final dynamic ontapFunc;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontapFunc,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(width * 0.04),
          border: Border.all(
            width: 1.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              icon,
              SizedBox(
                width: 7.w,
              ),
              Text(
                btnText,
                style: TextStyle(fontSize: 15.r),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";

// Compact and reusable button with details and icon
class DetailsButton extends StatelessWidget {
  const DetailsButton({
    super.key,
    required this.btnText,
    required this.icon,
    required this.onTap,
  });

  final String btnText;
  final Icon icon;
  final VoidCallback onTap; // Use VoidCallback for tap functions

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          border: Border.all(width: 1.w),
        ),
        child: Padding(
          padding: EdgeInsets.all(10.w),
          child: Row(
            children: [
              icon,
              const SizedBox(width: 7.0), // Use constants for fixed values
              Text(btnText,
                  style: TextStyle(
                      fontSize: 15.sp)), // Use sp for scalable font size
            ],
          ),
        ),
      ),
    );
  }
}

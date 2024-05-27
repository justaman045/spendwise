import "package:countup/countup.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Utils/theme.dart";

// TODO: Reduce Lines of Code
class CashFlow extends StatelessWidget {
  const CashFlow({
    super.key,
    required this.width,
    required this.flowText,
    required this.flowAmount,
  });

  final double width;
  final String flowText;
  final int flowAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(15.r),
      child: Row(
        children: [
          Container(
            width: (150.w),
            // color: Colors.black,
            decoration: BoxDecoration(
              gradient: MyAppColors.currentFlowcolor,
              borderRadius: BorderRadius.all(
                Radius.circular(20.r),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(15.r),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.r),
                    child: const Icon(
                      Icons.attach_money,
                      color: MyAppColors.normalColoredWidgetTextColorDarkMode,
                    ),
                  ),
                  Text(
                    flowText,
                    style: TextStyle(
                      fontSize: 16.r,
                      fontWeight: FontWeight.w500,
                      color: MyAppColors.normalColoredWidgetTextColorDarkMode,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Rs. ",
                        style: TextStyle(
                          fontSize: 15.r,
                          fontWeight: FontWeight.bold,
                          color:
                              MyAppColors.normalColoredWidgetTextColorDarkMode,
                        ),
                      ),
                      Countup(
                        duration: duration,
                        begin: 0,
                        end: flowAmount.toDouble(),
                        style: TextStyle(
                          fontSize: 25.r,
                          fontWeight: FontWeight.bold,
                          color:
                              MyAppColors.normalColoredWidgetTextColorDarkMode,
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

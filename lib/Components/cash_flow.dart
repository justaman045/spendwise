import "package:countup/countup.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Utils/theme.dart";

// Represents a cash flow item displayed on the screen
class CashFlow extends StatelessWidget {
  const CashFlow({
    super.key,
    required this.flowText, // Text describing the cash flow type (e.g., Income, Expense)
    required this.flowAmount, // The amount associated with the cash flow
  });

  final String flowText;
  final int flowAmount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: 10.w,
          vertical: 7.h), // Spacing around the cash flow widget
      child: Row(
        children: [
          Container(
            width: 150.w, // Fixed width for consistency
            decoration: BoxDecoration(
              gradient: MyAppColors.currentFlowcolor, // Apply gradient color
              borderRadius: BorderRadius.all(
                Radius.circular(20.r), // Rounded corners for aesthetics
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(13.r), // Padding within the container
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // Align text to the left
                children: [
                  Padding(
                    padding: EdgeInsets.all(5.r), // Spacing for the icon
                    child: Text(
                      '\u{20B9}', // Money icon to represent cash flow
                      style: TextStyle(
                        color: MyAppColors.normalColoredWidgetTextColorDarkMode,
                        fontSize: 25.r,
                      ),
                    ),
                  ),
                  Text(
                    flowText, // Display the cash flow type text
                    style: TextStyle(
                      fontSize: 16.r,
                      fontWeight: FontWeight.w500,
                      color: MyAppColors.normalColoredWidgetTextColorDarkMode,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Rs. ", // Rupee symbol for currency
                        style: TextStyle(
                          fontSize: 15.r,
                          fontWeight: FontWeight.bold,
                          color:
                              MyAppColors.normalColoredWidgetTextColorDarkMode,
                        ),
                      ),
                      Countup(
                        duration:
                            duration, // Animation duration (defined elsewhere)
                        begin: 0.0, // Start animation from 0
                        end: flowAmount
                            .toDouble(), // Convert int to double for animation
                        style: TextStyle(
                          fontSize: 25.r,
                          fontWeight: FontWeight.bold,
                          color:
                              MyAppColors.normalColoredWidgetTextColorDarkMode,
                        ),
                      ),
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

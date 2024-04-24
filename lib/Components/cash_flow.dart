import "package:countup/countup.dart";
import "package:flutter/material.dart";
import "package:spendwise/Requirements/data.dart";

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
      padding: EdgeInsets.all(width * 0.04),
      child: Row(
        children: [
          Container(
            width: (width * 0.42),
            // color: Colors.black,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromRGBO(230, 247, 241, 1),
                  Color.fromRGBO(228, 243, 243, 1),
                ],
              ),
              borderRadius: BorderRadius.all(
                Radius.circular(width * 0.03),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(width * 0.04),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.all(width * 0.01),
                    child: const Icon(
                      Icons.attach_money,
                    ),
                  ),
                  Text(
                    flowText,
                    style: TextStyle(
                      fontSize: width * 0.048,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        "Rs. ",
                        style: TextStyle(
                          fontSize: width * 0.06,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Countup(
                        duration: duration,
                        begin: 0,
                        end: flowAmount.toDouble(),
                        style: TextStyle(
                          fontSize: width * 0.07,
                          fontWeight: FontWeight.bold,
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

import "package:countup/countup.dart";
import "package:flutter/material.dart";

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
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.attach_money,
                    ),
                  ),
                  Text(
                    flowText,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Rs. ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Countup(
                        duration: const Duration(seconds: 1),
                        begin: 0,
                        end: flowAmount.toDouble(),
                        style: const TextStyle(
                          fontSize: 24,
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

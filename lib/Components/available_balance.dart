import "package:countup/countup.dart";
import "package:flutter/material.dart";
import "package:spendwise/Requirements/data.dart";

class AvailableBalance extends StatelessWidget {
  const AvailableBalance({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(width * 0.04),
      child: Container(
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromRGBO(210, 209, 254, 1),
                Color.fromRGBO(243, 203, 237, 1),
              ],
            ),
            borderRadius: BorderRadius.all(Radius.circular(width * 0.03))),
        // width: width,
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(width * 0.1),
            child: Column(
              children: [
                const Text(
                  "Avaiable Balance",
                  style: TextStyle(
                    fontSize: 15.0,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Rs. ",
                      style: TextStyle(
                        fontSize: 45.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Countup(
                      duration: const Duration(seconds: 1),
                      begin: 0,
                      end: balance.toDouble(),
                      style: const TextStyle(
                        fontSize: 45.0,
                        color: Colors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

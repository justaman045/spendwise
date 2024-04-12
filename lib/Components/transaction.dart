import 'package:countup/countup.dart';
import 'package:flutter/material.dart';

class TransactionWidget extends StatelessWidget {
  const TransactionWidget({
    super.key,
    required this.width,
    required this.name,
    required this.typeOfTransaction,
    required this.amount,
    required this.dateAndTime,
  });

  final double width;
  final String name;
  final String typeOfTransaction;
  final int amount;
  final String dateAndTime;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.all(width * 0.04),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueAccent,
              borderRadius: BorderRadius.all(
                Radius.circular(width * 0.04),
              ),
            ),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(width * 0.04),
                  child: const Icon(
                    Icons.shopping_cart,
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(
          width: width * 0.7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                    ),
                  ),
                  Row(
                    children: [
                      const Text(
                        "Rs. -",
                        style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Countup(
                        begin: 0,
                        end: amount.toDouble(),
                        style: const TextStyle(
                          color: Colors.redAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(typeOfTransaction),
                  Text(dateAndTime),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

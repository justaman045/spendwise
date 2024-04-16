import "package:flutter/material.dart";

class RecentTransactionHeader extends StatelessWidget {
  const RecentTransactionHeader({
    super.key,
    required this.width,
  });

  final double width;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(width * 0.04),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            "Today's Transaction",
            style: TextStyle(
              fontSize: 22.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: const Color.fromRGBO(225, 225, 254, 1),
            ),
            onPressed: () {},
            child: const Text(
              "See All..",
            ),
          ),
        ],
      ),
    );
  }
}

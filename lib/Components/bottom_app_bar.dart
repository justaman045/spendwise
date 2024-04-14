import "package:flutter/material.dart";

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    super.key,
    required this.width,
    required this.currentPage,
  });

  final double width;
  final String currentPage;

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.home_filled),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.payment_rounded),
          ),
          SizedBox(width: width * 0.09),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.person),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.settings),
          ),
        ],
      ),
    );
  }
}


//Implimentation

// bottomNavigationBar: BottomNavBar(
//   width: width,
//   currentPage: navBars[0],
// ),
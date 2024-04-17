import "package:flutter/material.dart";
import "package:spendwise/Requirements/data.dart";

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Welcome, $userName"),
      centerTitle: false,
      leading: IconButton(
        icon: const Icon(Icons.supervised_user_circle_outlined),
        onPressed: () {},
        tooltip: "Menu Icon",
      ),
      actions: [
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.wallet),
          tooltip: "Wallets Recognised",
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

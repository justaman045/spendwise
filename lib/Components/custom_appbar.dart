import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/recognized_accounts.dart";

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
  });

  // final GlobalKey scaffolKey;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text("Welcome, $userName"),
      centerTitle: false,
      // leading: IconButton(
      //   icon: const Icon(Icons.supervised_user_circle_outlined),
      //   onPressed: () => scaffolKey.currentState?.openDrawer(),
      //   tooltip: "Menu Icon",
      // ),
      actions: [
        IconButton(
          onPressed: () {
            Get.to(
                routeName: "Accounts",
                () => const RecognizedAccounts(),
                curve: customCurve,
                transition: customTrans,
                duration: duration);
          },
          icon: const Icon(Icons.wallet),
          tooltip: "Wallets Recognised",
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

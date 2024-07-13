import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/recognized_accounts.dart";

// Represents a custom app bar for the Spendwise app
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({
    super.key,
    required this.username,
  });

  final String username;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      // Title with username
      title: Text(
        "Welcome, $username",
        style: TextStyle(fontSize: 20.r),
      ),
      centerTitle: false,

      // Removed commented-out leading icon (can be re-added if needed)

      // Action icon for navigating to recognized accounts
      actions: [
        IconButton(
          onPressed: () => Get.to(
            routeName: "Accounts",
            () => const RecognizedAccounts(),
            curve: customCurve,
            transition: customTrans,
            duration: duration,
          ),
          icon: Icon(
            Icons.wallet,
            size: 20.h,
          ),
          tooltip: "Wallets Recognised",
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

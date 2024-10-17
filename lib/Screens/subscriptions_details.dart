import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Models/subscription.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/edit_subscription.dart";
import "package:spendwise/Utils/methods.dart";
import "package:spendwise/Utils/subscription_methods.dart";
import "package:spendwise/Utils/theme.dart";

class SubscriptionsDetails extends StatefulWidget {
  const SubscriptionsDetails({super.key, required this.subscription});

  final Subscription subscription;

  @override
  State<SubscriptionsDetails> createState() => _SubscriptionsDetailsState();
}

class _SubscriptionsDetailsState extends State<SubscriptionsDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.subscription.name),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.grey.withOpacity(0.25),
              ),
              width: double.infinity,
              height: 450.h,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                        child: Image(
                          width: 125.w,
                          height: 125.h,
                          image: AssetImage(
                              "assets/ottIcons/${widget.subscription.name.replaceAll(" ", "").toLowerCase()}.png"),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    widget.subscription.name,
                    style: TextStyle(fontSize: 25.r),
                  ),
                  //TODO: to add subtopics in near future
                  // Row(
                  //   children: [],
                  // ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 100.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Payment Date"),
                                      Text(widget.subscription.fromDate),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Cycle"),
                                      if ((widget.subscription.isRecurring).toString().toLowerCase() != "false") ...[
                                        Text(
                                            "${daysToMonths(stringToDateTime(widget.subscription.toDate).difference(stringToDateTime(widget.subscription.fromDate)).inDays)["months"]} months"),
                                      ] else ...[
                                        Text(
                                            "${daysToMonths(stringToDateTime(widget.subscription.isRecurring).difference(stringToDateTime(widget.subscription.fromDate)).inDays)["months"]} months"),
                                      ]
                                    ],
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100.h,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      const Text("Price"),
                                      Text(
                                          "Rs. ${widget.subscription.amount.toString()}"),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      if (stringToDateTime(
                                                  widget.subscription.toDate)
                                              .difference(DateTime.now())
                                              .inDays >
                                          -1) ...[
                                        const Text("Days Remaining"),
                                        if (stringToDateTime(
                                                    widget.subscription.toDate)
                                                .difference(DateTime.now())
                                                .inDays >=
                                            0) ...[
                                          Text(
                                              "${stringToDateTime(widget.subscription.toDate).difference(DateTime.now()).inDays} days to expire"),
                                        ],
                                      ],
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          child: Center(
                            child: Column(
                              children: [
                                const Text("Status"),
                                if (stringToDateTime(widget.subscription.toDate)
                                        .difference(DateTime.now())
                                        .inDays <
                                    0) ...[
                                  const Text("Expired"),
                                ] else ...[
                                  const Text("Active"),
                                ]
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff00B4DB),
                                Color(0xff0083B0),
                              ],
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              dynamic toRefresh = Get.to(
                                curve: customCurve,
                                transition: customTrans,
                                duration: duration,
                                () => EditSubscription(
                                  subscription: widget.subscription,
                                ),
                              );
                              if (toRefresh == "refresh") {
                                setState(() {});
                              }
                            },
                            child: const Text(
                              "Edit Subscription",
                              style: TextStyle(
                                color: MyAppColors
                                    .normalColoredWidgetTextColorDarkMode,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10.r)),
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xff00B4DB),
                                Color(0xff0083B0),
                              ],
                            ),
                          ),
                          child: TextButton(
                            onPressed: () {
                              SubscriptionMethods()
                                  .deleteSubscription(widget.subscription.id)
                                  .then(
                                    (val) => Get.back(result: "refresh"),
                                  );
                              // Get.back(result: "refresh");
                            },
                            child: const Text(
                              "Delete Subscription",
                              style: TextStyle(
                                color: MyAppColors
                                    .normalColoredWidgetTextColorDarkMode,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff00B4DB),
                        Color(0xff0083B0),
                      ],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: const Text(
                      "Go Back",
                      style: TextStyle(
                        color: MyAppColors.normalColoredWidgetTextColorDarkMode,
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(10.r)),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xff00B4DB),
                        Color(0xff0083B0),
                      ],
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      Get.snackbar(
                        "In Development",
                        "This Feature is Still Under Development",
                        snackPosition: SnackPosition.TOP,
                      );
                    },
                    child: const Text(
                      "Pause Subscription",
                      style: TextStyle(
                        color: MyAppColors.normalColoredWidgetTextColorDarkMode,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

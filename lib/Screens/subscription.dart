import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:showcaseview/showcaseview.dart";
import "package:spendwise/Components/subscription_manager_expense.dart";
import "package:spendwise/Models/subscription.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/active_subscription.dart";
import "package:spendwise/Screens/add_subscriptions.dart";
import "package:spendwise/Screens/subscriptions_details.dart";
import "package:spendwise/Utils/methods.dart";
import "package:spendwise/Utils/subscription_methods.dart";
import "package:spendwise/Utils/theme.dart";

class SubscriptionManager extends StatefulWidget {
  const SubscriptionManager({super.key});

  @override
  State<SubscriptionManager> createState() => _SubscriptionManagerState();
}

class _SubscriptionManagerState extends State<SubscriptionManager> {
  final GlobalKey _showcasekey = GlobalKey();
  dynamic subslengthE = 0;
  dynamic subslengthA = 0;
  Future? _future;
  Future<List<Subscription>> _getSubscriptions() async {
    List<Subscription> subscriptions =
        await SubscriptionMethods().getAllSubscriptions();
    return subscriptions
        .where((element) =>
            (stringToDateTime(element.toDate)
                    .difference(DateTime.now())
                    .inDays >=
                0) ||
            (stringToDateTime(element.recurringDate)
                    .difference(DateTime.now())
                    .inDays) >=
                0)
        .toList();
  }

  @override
  void initState() {
    _refreshData();
    super.initState();
    //TODO: ShowCaseWidget.of(context).startShowCase([_showcasekey]); run this post building of Widgets
  }

  Future<void> _refreshData() async {
    setState(() {
      _future = _getSubscriptions();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ShowCaseWidget(
      builder: (context) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Subscription Manager"),
            centerTitle: true,
            actions: [
              Showcase(
                key: _showcasekey,
                description: "All Expired Subscriptions are shown here",
                child: IconButton(
                  onPressed: () {
                    dynamic toRefresh = Get.to(
                      curve: customCurve,
                      transition: customTrans,
                      duration: duration,
                      () => const ActiveSubscription(),
                    );
                    if (toRefresh == "refresh") {
                      setState(() {
                        _refreshData();
                      });
                    }
                  },
                  icon: const Icon(Icons.subscriptions_rounded),
                ),
              ),
            ],
          ),
          body: RefreshIndicator(
            onRefresh: _refreshData,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SuscriptionManagerExpense(
                  getSubs: _getSubscriptions,
                ),
                FutureBuilder(
                  future: _future,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      if (snapshot.data == null) {
                        return Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No Subscriptions",
                                    style: TextStyle(fontSize: 20.r),
                                  ),
                                  TextButton(
                                    onPressed: () => _refreshData(),
                                    child: TextButton(
                                      onPressed: () => _refreshData(),
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10.r)),
                                          gradient: const LinearGradient(
                                            begin: Alignment.topLeft,
                                            end: Alignment.bottomRight,
                                            colors: [
                                              Color(0xff00B4DB),
                                              Color(0xff0083B0),
                                            ],
                                          ),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 10.h),
                                          child: const Text(
                                            "Refresh Subscription",
                                            style: TextStyle(
                                              color: MyAppColors
                                                  .normalColoredWidgetTextColorDarkMode,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      } else if (snapshot.data!.isEmpty) {
                        return Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "No Subscriptions",
                                    style: TextStyle(fontSize: 20.r),
                                  ),
                                  TextButton(
                                    onPressed: () => _refreshData(),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(10.r)),
                                        gradient: const LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            Color(0xff00B4DB),
                                            Color(0xff0083B0),
                                          ],
                                        ),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10.w, vertical: 10.h),
                                        child: const Text(
                                          "Refresh Subscription",
                                          style: TextStyle(
                                            color: MyAppColors
                                                .normalColoredWidgetTextColorDarkMode,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      }
                      List<Subscription> subscriptionList =
                          snapshot.data!.reversed.toList();

                      return Expanded(
                        child: ListView.builder(
                          itemCount: subscriptionList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 5.h),
                              child: GestureDetector(
                                onTap: () async {
                                  final toRefresh = await Get.to(
                                    curve: customCurve,
                                    transition: customTrans,
                                    duration: duration,
                                    () => SubscriptionsDetails(
                                      subscription: subscriptionList[index],
                                    ),
                                  );
                                  if (toRefresh != null) {
                                    setState(() {
                                      _refreshData();
                                    });
                                  }
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15.r),
                                    color: Colors.grey.withOpacity(0.25),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 15.w, vertical: 10.h),
                                    child: Row(
                                      children: [
                                        Image(
                                          image: AssetImage(
                                              "assets/ottIcons/${subscriptionList[index].name.replaceAll(" ", "").toLowerCase()}.png"),
                                          height: 30.h,
                                          width: 50.w,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                subscriptionList[index].name,
                                                style:
                                                    TextStyle(fontSize: 18.r),
                                              ),
                                              if (stringToDateTime(
                                                          subscriptionList[
                                                                  index]
                                                              .toDate)
                                                      .difference(
                                                          DateTime.now())
                                                      .inDays <=
                                                  31) ...[
                                                Text(
                                                    "${stringToDateTime(subscriptionList[index].toDate).difference(DateTime.now()).inDays} Days Remaining"),
                                              ] else ...[
                                                Text(
                                                    "${daysToMonths(stringToDateTime(subscriptionList[index].toDate).difference(DateTime.now()).inDays)["months"]} Months Remianing"),
                                              ]
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
          // a floating action button to add the cash entry
          //TODO: remove the floating action button when maximum limit is reached
          floatingActionButton: FloatingActionButton.extended(
            label: const Icon(Icons.add),
            onPressed: () async {
              List<Subscription> subscribed =
                  await SubscriptionMethods().getAllSubscriptions();
              List<String> subs = await getSubscriptionApps();
              if (subscribed.length != subs.length) {
                final toreload = await Get.to(
                  routeName: routes[14],
                  () => const AddSubscriptions(),
                  curve: customCurve,
                  transition: customTrans,
                  duration: duration,
                );

                if (toreload != null) {
                  setState(() {});
                }
              } else {
                Get.snackbar(
                    "Limit Reached", "Maximum number Of Platforms Reached",
                    snackPosition: SnackPosition.BOTTOM);
              }
            },
          ),
        );
      },
    );
  }
}

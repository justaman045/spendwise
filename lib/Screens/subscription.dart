import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:showcaseview/showcaseview.dart";
import "package:spendwise/Components/subscription_manager_expense.dart";
import "package:spendwise/Models/subscription.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/active_subscription.dart";
import "package:spendwise/Screens/add_subscriptions.dart";
import "package:spendwise/Utils/methods.dart";
import "package:spendwise/Utils/subscription_methods.dart";
import "package:spendwise/Utils/theme.dart";

import "../Components/subscription_widgets.dart";

class SubscriptionManager extends StatefulWidget {
  const SubscriptionManager({super.key});

  @override
  State<SubscriptionManager> createState() => _SubscriptionManagerState();
}

class _SubscriptionManagerState extends State<SubscriptionManager> {
  final GlobalKey _showcasekey = GlobalKey();
  dynamic subslengthE = 0;
  dynamic subslengthA = 0;
  final GlobalKey _subscriptionExpense = GlobalKey();
  final GlobalKey _addAExpense = GlobalKey();

  Future<List<Subscription>> _getSubscriptions() async {
    List<Subscription> subscriptions =
        await SubscriptionMethods().getAllSubscriptions();
    return subscriptions
        .where((element) =>
            (stringToDateTime(element.toDate)
                    .difference(DateTime.now())
                    .inDays >=
                0) ||
            element.isRecurring.toString().toLowerCase() != "false")
        .toList();
  }

  DateTime getNextPaymentDate(
      DateTime subscriptionStartDate, String paymentFrequency) {
    // Calculate the difference based on the payment frequency
    Duration difference;
    switch (paymentFrequency) {
      case "1 Day":
        difference = const Duration(days: 1);
        break;
      case "3 Days":
        difference = const Duration(days: 3);
        break;
      case "1 Week":
        difference = const Duration(days: 7);
        break;
      case "28 Days":
        difference = const Duration(days: 28);
        break;
      case "1 Month":
        difference = const Duration(days: 30);
        break;
      case "56 Days":
        difference = const Duration(days: 56);
        break;
      case "2 Months":
        difference = const Duration(days: 60);
        break;
      case "84 Days":
        difference = const Duration(days: 84);
        break;
      case "3 Months":
        difference = const Duration(days: 90);
        break;
      case "4 Months":
        difference = const Duration(days: 120);
        break;
      case "6 Months":
        difference = const Duration(days: 180);
        break;
      case "8 Months":
        difference = const Duration(days: 240);
        break;
      case "1 Year":
        difference = const Duration(days: 365);
        break;
      default:
        throw ArgumentError("Invalid payment frequency");
    }

    // Calculate the next payment date
    DateTime nextPaymentDate = subscriptionStartDate.add(difference);

    // Return the next payment date
    return nextPaymentDate;
  }

  void setAllRecurring(List<Subscription> subscription) {
    debugPrint("Running");
    for (var sub in subscription) {
      if ((stringToDateTime(sub.toDate).isBefore(DateTime.now())) &&
          (sub.isRecurring.toLowerCase() == "true")) {
        DateTime nextPaymentDate = stringToDateTime(sub.toDate);
        while (nextPaymentDate.isBefore(DateTime.now())) {
          nextPaymentDate =
              nextPaymentDate.add(Duration(days: getTenureInDays(sub.tenure)));
        }
        SubscriptionMethods().updateSubscription(Subscription(
            fromDate: sub.fromDate,
            toDate: DateFormat.yMMMMd().format(nextPaymentDate),
            amount: sub.amount,
            name: sub.name,
            isRecurring: sub.isRecurring,
            tenure: sub.tenure));
      }
    }
  }

  @override
  void initState() {
    _refreshData();
    super.initState();
    _checkFirstTime();
    //TODO: ShowCaseWidget.of(context).startShowCase([_showcasekey]); run this post building of Widgets
  }

  Future<void> _refreshData() async {
    setState(() {
      _getSubscriptions();
    });
  }

  Future<void> _checkFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('isFirstTimeSubscriptionsActive') ?? true;

    if (isFirstTime) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ShowCaseWidget.of(context)
            .startShowCase([_showcasekey, _subscriptionExpense, _addAExpense]);
      });

      prefs.setBool('isFirstTimeSubscriptionsActive', false);
    }
  }

  @override
  Widget build(BuildContext context) {
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
            Showcase(
              key: _subscriptionExpense,
              description:
                  "How much you're spending this month for subscriptions",
              child: SubscriptionManagerExpense(
                getSubs: _getSubscriptions,
              ),
            ),
            FutureBuilder(
              future: _getSubscriptions(),
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
                  List<Subscription> subscriptionList = snapshot.data!.toList();
                  subscriptionList.sort((a, b) =>
                      (stringToDateTime(a.toDate).difference(DateTime.now()))
                          .inDays
                          .compareTo(stringToDateTime(b.toDate)
                              .difference(DateTime.now())
                              .inDays));
                  setAllRecurring(subscriptionList);

                  return SubscriptionWidgets(
                      subscriptionList: subscriptionList,
                      callBackMethod: () {
                        setState(() {
                          _refreshData();
                        });
                      });
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
      floatingActionButton: Showcase(
        key: _addAExpense,
        description: "Add a New Subscription from here",
        child: FloatingActionButton.extended(
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
                setState(() {
                  _refreshData();
                });
              }
            } else {
              Get.snackbar(
                  "Limit Reached", "Maximum number Of Platforms Reached",
                  snackPosition: SnackPosition.BOTTOM);
            }
          },
        ),
      ),
    );
  }
}

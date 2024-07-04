import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Components/subscription_manager_expense.dart";
import "package:spendwise/Models/db_helper.dart";
import "package:spendwise/Requirements/data.dart";
import "package:spendwise/Screens/add_subscriptions.dart";
import "package:spendwise/Screens/subscriptions_details.dart";
import "package:spendwise/Utils/methods.dart";

class ActiveSubscription extends StatefulWidget {
  const ActiveSubscription({super.key});

  @override
  State<ActiveSubscription> createState() => _ActiveSubscriptionState();
}

class _ActiveSubscriptionState extends State<ActiveSubscription> {
  Future<List<Subscription>> _getSubscriptions() async {
    List<Subscription> subscriptions =
        await DatabaseHelper().getAllSubscriptions();
    return subscriptions
        .where((element) =>
            stringToDateTime(element.toDate).difference(DateTime.now()).inDays <
            0)
        .toList();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Expired Subscriptions"),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        onRefresh: _getSubscriptions,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SuscriptionManagerExpense(
              getSubs: _getSubscriptions,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: const Text("Expired Subscriptions"),
            ),
            FutureBuilder(
              future: _getSubscriptions(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.data == null) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          "No Subscriptions",
                          style: TextStyle(fontSize: 20.r),
                        ),
                      ),
                    );
                  } else if (snapshot.data!.isEmpty) {
                    return Expanded(
                      child: Center(
                        child: Text(
                          "No Subscriptions",
                          style: TextStyle(fontSize: 20.r),
                        ),
                      ),
                    );
                  }
                  debugPrint(snapshot.data!.length.toString());
                  List<Subscription> subscriptionList = snapshot.data!;
                  // debugPrint(subscriptionList[1]
                  //     .name
                  //     .replaceAll(" ", "")
                  //     .toLowerCase());
                  return Expanded(
                    child: ListView.builder(
                      itemCount: subscriptionList.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15.w, vertical: 5.h),
                          child: GestureDetector(
                            onTap: () => Get.to(
                              curve: customCurve,
                              transition: customTrans,
                              duration: duration,
                              () => SubscriptionsDetails(
                                subscription: subscriptionList[index],
                              ),
                            ),
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
                                            style: TextStyle(fontSize: 18.r),
                                          ),
                                          Text(
                                            "Expired ${stringToDateTime(subscriptionList[index].toDate).difference(DateTime.now()).inDays.abs()} Days ago",
                                            style: TextStyle(fontSize: 13.r),
                                          )
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
              await DatabaseHelper().getAllSubscriptions();
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
              // debugPrint(toreload.toString());
              setState(() {});
            }
          } else {
            Get.snackbar("Limit Reached", "Maximum number Of Platforms Reached",
                snackPosition: SnackPosition.BOTTOM);
          }
        },
      ),
    );
  }
}

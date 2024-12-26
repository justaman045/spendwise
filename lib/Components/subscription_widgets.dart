import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendwise/Models/subscription.dart';

import '../Requirements/data.dart';
import '../Screens/subscriptions_details.dart';
import '../Utils/methods.dart';

class SubscriptionWidgets extends StatelessWidget {
  const SubscriptionWidgets(
      {super.key,
      required this.subscriptionList,
      required this.callBackMethod});

  final List<Subscription> subscriptionList;
  final Function callBackMethod;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: subscriptionList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 5.h),
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
                  callBackMethod();
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Colors.grey.withValues(alpha: 0.25),
                ),
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                  child: Row(
                    children: [
                      Image(
                        image: AssetImage(
                            "assets/ottIcons/${subscriptionList[index].name.replaceAll(" ", "").toLowerCase()}.png"),
                        height: 30.h,
                        width: 50.w,
                        errorBuilder: (context, error, stackTrace) {
                          return SizedBox(
                            width: 50.w,
                            child: const Text('No Image Support'),
                          );
                        },
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              subscriptionList[index].name,
                              style: TextStyle(fontSize: 18.r),
                            ),
                            if (stringToDateTime(subscriptionList[index].toDate)
                                    .difference(DateTime.now())
                                    .inDays <=
                                7) ...[const Text("Expiring this Week")],
                            if ((stringToDateTime(
                                            subscriptionList[index].toDate)
                                        .difference(DateTime.now())
                                        .inDays >
                                    7) &&
                                (stringToDateTime(
                                            subscriptionList[index].toDate)
                                        .difference(DateTime.now())
                                        .inDays <=
                                    14)) ...[const Text("Expiring Next Week")],
                            if((stringToDateTime(subscriptionList[index].toDate).difference(DateTime.now()).inDays < 30) || (stringToDateTime(subscriptionList[index].toDate).difference(DateTime.now()).inDays < 28)) ...[
                              Text(
                                  "${stringToDateTime(subscriptionList[index].toDate).difference(DateTime.now()).inDays} days Remaining"),
                            ] else ...[
                              Text(
                                  "${daysToMonths(stringToDateTime(subscriptionList[index].toDate).difference(DateTime.now()).inDays)["months"]} months and ${daysToMonths(stringToDateTime(subscriptionList[index].toDate).difference(DateTime.now()).inDays)["remainingDays"]} days Remaining"),
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
  }
}

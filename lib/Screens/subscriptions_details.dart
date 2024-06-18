import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:spendwise/Models/db_helper.dart";
import "package:spendwise/Utils/methods.dart";

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
              height: 500.h,
              child: Column(
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
                  Row(
                    children: [],
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 15.w, vertical: 15.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Payment Date"),
                                Text(widget.subscription.fromDate),
                                const Text("Cycle"),
                                Text(
                                    "${daysToMonths(stringToDateTime(widget.subscription.toDate).difference(stringToDateTime(widget.subscription.fromDate)).inDays)["months"]} months"),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text("Price"),
                                Text(
                                    "Rs. ${widget.subscription.amount.toString()}"),
                                if (stringToDateTime(widget.subscription.toDate)
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
                                ]
                              ],
                            ),
                          ],
                        ),
                        Center(
                          child: Column(
                            children: [
                              Text("Status"),
                              if (stringToDateTime(widget.subscription.toDate)
                                      .difference(DateTime.now())
                                      .inDays <
                                  0) ...[
                                Text("Expired"),
                              ] else ...[
                                Text("Active"),
                              ]
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/Models/subscription.dart';
import 'package:spendwise/Utils/methods.dart';
import 'package:spendwise/Utils/subscription_methods.dart';

class AddSubscriptions extends StatefulWidget {
  const AddSubscriptions({super.key});

  @override
  State<AddSubscriptions> createState() => _AddSubscriptionsState();
}

class _AddSubscriptionsState extends State<AddSubscriptions> {
  final String _dateTime = "";
  TextEditingController fromDate = TextEditingController();
  TextEditingController toDate = TextEditingController();
  TextEditingController amount = TextEditingController();
  TextEditingController endingRecurring = TextEditingController();
  DateTime? fromdate;
  DateTime? todate;
  DateTime? recurringDate;
  String selectedApp = "";
  List<Subscription> subsbriptions = [];
  List<String> availableSubscriptions = [];
  bool isRecurring = false;

  void getSubs() async {
    List<String> subs = await getSubscriptionApps();
    subsbriptions = await SubscriptionMethods().getAllSubscriptions();
    availableSubscriptions = subs
        .where((subName) => !subsbriptions.any((subscribed) =>
            (subscribed.name == subName) &&
            (!stringToDateTime(subscribed.toDate)
                .difference(DateTime.now())
                .inDays
                .isLowerThan(0))))
        .toList();

    availableSubscriptions.map((e) => debugPrint(e));
    setState(() {});
  }

  @override
  void initState() {
    getSubs();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> sub = [];
    subsbriptions.map((elem) => sub.add(elem.name));
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Subcription"),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.r),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 5.w, bottom: 20.h),
              child: Row(
                children: [
                  Text(
                    "Subscription Details",
                    style: TextStyle(fontSize: 18.r),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.r),
              child: DropdownButtonFormField(
                decoration: InputDecoration(
                  label: const Text("Name Of the Subscription"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
                items: availableSubscriptions.map((subscriptionName) {
                  return DropdownMenuItem(
                    value: subscriptionName,
                    child: Text(subscriptionName),
                  );
                }).toList(),
                onChanged: (element) {
                  if (element != null) {
                    selectedApp = element;
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.r),
              child: TextFormField(
                canRequestFocus: false,
                keyboardType: TextInputType.none,
                controller: fromDate,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month_rounded),
                    onPressed: () async {
                      dynamic date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 1),
                          lastDate: DateTime(2099));
                      fromdate = date;
                      fromDate.text = DateFormat.yMMMMd().format(date);
                    },
                  ),
                  label: const Text("Start Date of the Subscription"),
                  hintText: _dateTime.toString(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.r),
              child: TextFormField(
                canRequestFocus: false,
                keyboardType: TextInputType.none,
                controller: toDate,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.calendar_month_rounded),
                    onPressed: () async {
                      dynamic date = await showDatePicker(
                          context: context,
                          firstDate: DateTime(DateTime.now().year - 1),
                          lastDate: DateTime(2099));
                      todate = date;
                      toDate.text = DateFormat.yMMMMd().format(date);
                    },
                  ),
                  label: const Text("Ending Date of the Subscription"),
                  hintText: _dateTime.toString(),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.r),
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: amount,
                decoration: InputDecoration(
                  label: const Text("Amount"),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.r),
                  ),
                ),
              ),
            ),
            Row(
              children: [
                Checkbox(
                  value: isRecurring,
                  onChanged: (bool? value) {
                    endingRecurring.text = "";
                    setState(
                      () {
                        isRecurring = value!;
                      },
                    );
                  },
                ),
                const Text("Is this Subscription Recurring??")
              ],
            ),
            if (isRecurring) ...[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.r),
                child: TextFormField(
                  keyboardType: TextInputType.none,
                  controller: endingRecurring,
                  decoration: InputDecoration(
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_month_rounded),
                      onPressed: () async {
                        dynamic date = await showDatePicker(
                            context: context,
                            firstDate: DateTime(DateTime.now().year - 1),
                            lastDate: DateTime(2099));
                        recurringDate = date;
                        endingRecurring.text = DateFormat.yMMMMd().format(date);
                      },
                    ),
                    label: const Text("Recurring Upto"),
                    hintText: _dateTime.toString(),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                    ),
                  ),
                ),
              ),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Container(
                    width: 150.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          13.h,
                        ),
                      ),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.black54,
                          Colors.black87,
                        ],
                      ),
                    ),
                    child: TextButton(
                      onPressed: () {
                        if (fromdate != null && todate != null) {
                          if (endingRecurring.text.isEmpty) {
                            endingRecurring.text = toDate.text;
                          }
                          if (endingRecurring.text.isNotEmpty) {
                            toDate.text = endingRecurring.text;
                          }
                          Subscription subscription = Subscription(
                            fromDate: fromDate.text,
                            toDate: toDate.text,
                            amount: double.parse(amount.text),
                            recurringDate: endingRecurring.text,
                            name: selectedApp,
                          );
                          SubscriptionMethods()
                              .insertSubscription(subscription)
                              .then((value) => Get.back(result: "refresh"));
                        } else {
                          Get.snackbar("Error in Date", "Choose correct Date");
                        }
                      },
                      child: const Text(
                        "Add Subscription",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.h),
                  child: Container(
                    width: 150.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(
                          13.h,
                        ),
                      ),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Colors.black54,
                          Colors.black87,
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
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

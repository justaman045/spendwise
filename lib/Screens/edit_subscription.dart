import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/Models/subscription.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendwise/Utils/methods.dart';
import 'package:spendwise/Utils/subscription_methods.dart';
import 'package:spendwise/Utils/theme.dart';

final _formKey = GlobalKey<FormState>();

//TODO: Complete the page
class EditSubscription extends StatefulWidget {
  const EditSubscription({super.key, required this.subscription});

  final Subscription subscription;

  @override
  State<EditSubscription> createState() => _EditSubscriptionState();
}

class _EditSubscriptionState extends State<EditSubscription> {
  TextEditingController amountController = TextEditingController();
  TextEditingController tenureController = TextEditingController();
  TextEditingController endingRecurring = TextEditingController();
  TextEditingController dateController = TextEditingController();
  late bool isRecurring;
  DateTime? _dateTime;
  late String fromDate;

  @override
  void initState() {
    amountController.text = widget.subscription.amount.toString();
    isRecurring =
        widget.subscription.isRecurring.toString().toLowerCase() == "true";
    dateController.text = widget.subscription.fromDate;
    tenureController.text = widget.subscription.tenure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Subscription : ${widget.subscription.name}"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.w),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.r),
                      color: Colors.grey.withValues(alpha: 0.25),
                    ),
                    width: double.infinity,
                    height: 150.h,
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
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10.h,
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(vertical: 10.r, horizontal: 20.w),
                  child: TextFormField(
                    canRequestFocus: false,
                    keyboardType: TextInputType.none,
                    controller: dateController,
                    decoration: InputDecoration(
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.calendar_month_rounded),
                        onPressed: () async {
                          dynamic date = await showDatePicker(
                              context: context,
                              firstDate: DateTime(DateTime.now().year - 1),
                              lastDate: DateTime(2099));
                          if (date == null) {
                            date = stringToDateTime(dateController.text);
                          } else {
                            dateController.text =
                                DateFormat.yMMMMd().format(date);
                          }
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
                  padding: EdgeInsets.only(
                    left: 20.r,
                    top: 15.h,
                    right: 20.w,
                  ),
                  child: SizedBox(
                    height: 60.h,
                    child: TextFormField(
                      controller: amountController,
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(RegExp('[0-9]'))
                      ],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Add a Price";
                        } else if (double.parse(value).toInt() <= 0) {
                          return "Price must be greater than 0";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        label: Text(
                          "Amount",
                          style: TextStyle(
                            fontSize: 13.r,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.h),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    left: 20.r,
                    top: 15.h,
                    right: 20.w,
                  ),
                  child: DropdownButtonFormField(
                    value: widget.subscription.tenure,
                    decoration: InputDecoration(
                      label: const Text("Tenure"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.r),
                      ),
                    ),
                    items: [
                      "1 Day",
                      "3 Days",
                      "1 Week",
                      "1 Month",
                      "2 Months",
                      "3 Months",
                      "4 Months",
                      "6 Months",
                      "8 Months",
                      "1 Year"
                    ].map((tenure) {
                      return DropdownMenuItem(
                        value: tenure,
                        child: Text(tenure),
                      );
                    }).toList(),
                    onChanged: (element) {
                      if (element != null) {
                        tenureController.text = element;
                      }
                    },
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Row(
                    children: [
                      Checkbox(
                        value: isRecurring,
                        onChanged: (bool? value) {
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
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: colorsOfGradient(),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: TextButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    DateTime? todate =
                        stringToDateTime(widget.subscription.toDate);
                    if (dateController.text != widget.subscription.fromDate &&
                        widget.subscription.tenure == tenureController.text) {
                      switch (widget.subscription.tenure) {
                        case "1 Day":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: 1));
                            break;
                          }
                        case "3 Days":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: 3));
                            break;
                          }
                        case "1 Week":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: 7));
                            break;
                          }
                        case "1 Month":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 1)));
                            break;
                          }
                        case "2 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 2)));
                            break;
                          }
                        case "3 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 3)));
                            break;
                          }
                        case "4 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 4)));
                            break;
                          }
                        case "6 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 6)));
                            break;
                          }
                        case "8 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 8)));
                            break;
                          }
                        case "1 Year":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 12)));
                            break;
                          }
                      }
                    } else if (widget.subscription.fromDate !=
                            dateController.text &&
                        tenureController.text != widget.subscription.tenure) {
                      switch (tenureController.text) {
                        case "1 Day":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: 1));
                            break;
                          }
                        case "3 Days":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: 3));
                            break;
                          }
                        case "1 Week":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: 7));
                            break;
                          }
                        case "1 Month":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 1)));
                            break;
                          }
                        case "2 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 2)));
                            break;
                          }
                        case "3 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 3)));
                            break;
                          }
                        case "4 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 4)));
                            break;
                          }
                        case "6 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 6)));
                            break;
                          }
                        case "8 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 8)));
                            break;
                          }
                        case "1 Year":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 12)));
                            break;
                          }
                      }
                    } else if (widget.subscription.fromDate ==
                            dateController.text &&
                        tenureController.text != widget.subscription.tenure) {
                      switch (tenureController.text) {
                        case "1 Day":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: 1));
                            break;
                          }
                        case "3 Days":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: 3));
                            break;
                          }
                        case "1 Week":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: 7));
                            break;
                          }
                        case "1 Month":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 1)));
                            break;
                          }
                        case "2 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 2)));
                            break;
                          }
                        case "3 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 3)));
                            break;
                          }
                        case "4 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 4)));
                            break;
                          }
                        case "6 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 6)));
                            break;
                          }
                        case "8 Months":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 8)));
                            break;
                          }
                        case "1 Year":
                          {
                            todate = stringToDateTime(dateController.text)
                                .add(const Duration(days: (30 * 12)));
                            break;
                          }
                      }
                    }
                    Subscription subscription = Subscription(
                      fromDate: dateController.text,
                      toDate: DateFormat.yMMMMd().format(todate),
                      amount: double.parse(amountController.text),
                      name: widget.subscription.name,
                      isRecurring: isRecurring.toString(),
                      tenure: tenureController.text,
                    );
                    if (subscription.fromDate == widget.subscription.fromDate &&
                        subscription.toDate == widget.subscription.toDate &&
                        subscription.amount == widget.subscription.amount &&
                        subscription.isRecurring ==
                            widget.subscription.isRecurring &&
                        subscription.tenure == widget.subscription.tenure) {
                      Get.snackbar("Error", "You haven't changed anything");
                    } else {
                      SubscriptionMethods()
                          .updateSubscription(subscription)
                          .then((value) => Get.back(result: "refresh"))
                          .then((value) => Get.back(result: "refresh"));
                    }
                  }
                },
                child: const Text("Save Subscription")),
          )
        ],
      ),
    );
  }
}

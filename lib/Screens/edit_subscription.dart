import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:spendwise/Models/subscription.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
//TODO: Complete the page
class EditSubscription extends StatefulWidget {
  const EditSubscription({super.key, required this.subscription});

  final Subscription subscription;

  @override
  State<EditSubscription> createState() => _EditSubscriptionState();
}

class _EditSubscriptionState extends State<EditSubscription> {

  TextEditingController amountController = TextEditingController();
  TextEditingController TenureController = TextEditingController();
  TextEditingController endingRecurring = TextEditingController();
  late bool isRecurring;

  @override
  void initState() {
    amountController.text = widget.subscription.amount.toString();
    isRecurring = widget.subscription.isRecurring.toString().toLowerCase() == "true";
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Colors.grey.withOpacity(0.25),
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
                  FilteringTextInputFormatter.allow(
                      RegExp('[0-9]'))
                ],
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Add a Price";
                  } else if (int.parse(value) > 0) {
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
            padding: EdgeInsets.only(left: 20.r,
              top: 15.h,
              right: 20.w,),
            child: DropdownButtonFormField(
              value: widget.subscription.tenure,
              decoration: InputDecoration(
                label: const Text("Tenure"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.r),
                ),
              ),
              items: ["1 Day", "3 Days", "1 Week", "1 Month", "2 Months", "3 Months", "4 Months", "6 Months", "8 Months", "1 Year"].map((tenure) {
                return DropdownMenuItem(
                  value: tenure,
                  child: Text(tenure),
                );
              }).toList(),
              onChanged: (element) {
                if (element != null) {
                  TenureController.text = element;
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Row(
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
          ),
        ],
      ),
    );
  }
}

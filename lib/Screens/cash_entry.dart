import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Requirements/data.dart";

final _formKey = GlobalKey<FormState>();

class AddCashEntry extends StatefulWidget {
  const AddCashEntry({super.key});

  @override
  State<AddCashEntry> createState() => _AddCashEntryState();
}

class _AddCashEntryState extends State<AddCashEntry> {
  TextEditingController nameEditingController = TextEditingController();
  TextEditingController amountEditingController = TextEditingController();
  TextEditingController typeOftransactionEditingController =
      TextEditingController();
  TextEditingController expenseTypeEditingController = TextEditingController();
  String typeOfexp = "";
  String typeOftransaction = "";
  String transactionReferanceNumber = "";
  @override
  void initState() {
    expenseTypeEditingController.text = expenseType[0];
    typeOftransactionEditingController.text = typeOfTransaction[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Cash Payment",
          style: TextStyle(fontSize: 20.r),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 30.h,
                left: 20.w,
              ),
              child: Text(
                "Payment Details",
                style: TextStyle(
                  fontSize: 20.r,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 20.r,
                      top: 15.h,
                      right: 20.w,
                    ),
                    child: SizedBox(
                      height: 60.h,
                      child: TextFormField(
                        controller: nameEditingController,
                        decoration: InputDecoration(
                          label: Text(
                            "Recipient Name",
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
                    child: SizedBox(
                      height: 60.h,
                      child: TextFormField(
                        controller: amountEditingController,
                        keyboardType: TextInputType.number,
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
                    child: SizedBox(
                      height: 60.h,
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          label: Text(
                            "Income/Expense",
                            style: TextStyle(
                              fontSize: 13.r,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.h),
                          ),
                        ),
                        value: typeOfexp,
                        items: expenseType
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    fontSize: 13.r,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? value) => setState(
                          () {
                            if (value != null) typeOfexp = value;
                          },
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
                      child: DropdownButtonFormField(
                        decoration: InputDecoration(
                          label: Text(
                            "Type Of Transaction",
                            style: TextStyle(
                              fontSize: 13.r,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.h),
                          ),
                        ),
                        value: typeOftransaction,
                        items: typeOfTransaction
                            .map(
                              (e) => DropdownMenuItem(
                                value: e,
                                child: Text(
                                  e,
                                  style: TextStyle(
                                    fontSize: 13.r,
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                        onChanged: (String? value) => setState(
                          () {
                            if (value != null) typeOftransaction = value;
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 50.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.off(
                        routeName: "saveAndAdd",
                        () => const AddCashEntry(),
                        curve: customCurve,
                        transition: customTrans,
                        duration: duration,
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.h),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromRGBO(210, 209, 254, 1),
                            Color.fromRGBO(243, 203, 237, 1),
                          ],
                        ),
                      ),
                      width: 150.w,
                      height: 50.h,
                      child: Center(
                        child: Text(
                          "Save and Add another",
                          style: TextStyle(fontSize: 13.r),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // FirebaseF
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(11.w),
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromRGBO(210, 209, 254, 1),
                            Color.fromRGBO(243, 203, 237, 1),
                          ],
                        ),
                      ),
                      width: 150.w,
                      height: 50.h,
                      child: Center(
                        child: Text(
                          "Add Payment",
                          style: TextStyle(
                            fontSize: 13.r,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 43.h),
              child: Center(
                child: GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.w),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromRGBO(210, 209, 254, 1),
                          Color.fromRGBO(243, 203, 237, 1),
                        ],
                      ),
                    ),
                    width: 100.w,
                    height: 50.h,
                    child: const Center(
                      child: Text("Go Back"),
                    ),
                  ),
                  onTap: () => Get.back(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

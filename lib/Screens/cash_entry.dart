import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:spendwise/Requirements/data.dart";

class AddCashEntry extends StatefulWidget {
  const AddCashEntry({super.key});

  @override
  State<AddCashEntry> createState() => _AddCashEntryState();
}

class _AddCashEntryState extends State<AddCashEntry> {
  String typeOfexp = "";
  String typeOftransaction = "";
  @override
  void initState() {
    typeOfexp = expenseType[0];
    typeOftransaction = typeOfTransaction[0];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cash Payment"),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.04, left: width * 0.06),
            child: Text(
              "Payment Details",
              style: TextStyle(
                fontSize: width * 0.055,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.06,
              top: height * 0.02,
              right: width * 0.06,
            ),
            child: TextFormField(
              decoration: InputDecoration(
                label: const Text("Recipient Name"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * 0.04),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.06,
              top: height * 0.02,
              right: width * 0.06,
            ),
            child: TextFormField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                label: const Text("Amount"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * 0.04),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.06,
              top: height * 0.02,
              right: width * 0.06,
            ),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                label: const Text("Income/Expense"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * 0.04),
                ),
              ),
              value: typeOfexp,
              items: expenseType
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
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
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.06,
              top: height * 0.02,
              right: width * 0.06,
            ),
            child: DropdownButtonFormField(
              decoration: InputDecoration(
                label: const Text("Type Of Transaction"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(width * 0.04),
                ),
              ),
              value: typeOftransaction,
              items: typeOfTransaction
                  .map(
                    (e) => DropdownMenuItem(
                      value: e,
                      child: Text(e),
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
          Padding(
            padding: EdgeInsets.only(top: height * 0.1),
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
                      borderRadius: BorderRadius.circular(width * 0.05),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromRGBO(210, 209, 254, 1),
                          Color.fromRGBO(243, 203, 237, 1),
                        ],
                      ),
                    ),
                    width: width * 0.4,
                    height: height * 0.07,
                    child: const Center(
                      child: Text("Save and Add another"),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.05),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(210, 209, 254, 1),
                        Color.fromRGBO(243, 203, 237, 1),
                      ],
                    ),
                  ),
                  width: width * 0.3,
                  height: height * 0.07,
                  child: const Center(
                    child: Text("Add Payment"),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: height * 0.05),
            child: Center(
              child: GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(width * 0.05),
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Color.fromRGBO(210, 209, 254, 1),
                        Color.fromRGBO(243, 203, 237, 1),
                      ],
                    ),
                  ),
                  width: width * 0.8,
                  height: height * 0.07,
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
    );
  }
}

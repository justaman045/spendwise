import "package:flutter/material.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";

class TransactionDetails extends StatelessWidget {
  const TransactionDetails({
    super.key,
    required this.toName,
    required this.amount,
    required this.dateTime,
    required this.transactionReferanceNumber,
    required this.expenseType,
  });

  final String toName;
  final int amount;
  final DateTime dateTime;
  final int transactionReferanceNumber;
  final String expenseType;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.15),
            child: const Center(
              child: Image(
                image: AssetImage("assets/resources/success.gif"),
              ),
            ),
          ),
          if (expenseType == "expense") ...[
            const Center(
              child: Text(
                "Payment Sucessfull",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.02),
                child: Text("You've paid to $toName"),
              ),
            ),
          ] else ...[
            const Center(
              child: Text(
                "Payment Recieved",
                style: TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.02),
                child: const Text(
                    "You've recived Income, keep saving and Investing."),
              ),
            ),
          ],
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.02),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DetailsButton(
                  width: width,
                  btnText: "Share",
                  icon: const Icon(Icons.share),
                ),
                DetailsButton(
                  width: width,
                  btnText: "Print",
                  icon: const Icon(Icons.print),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.09,
              right: width * 0.09,
              top: width * 0.05,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (expenseType == "income") ...[
                  const Text("From"),
                ] else ...[
                  const Text("To"),
                ],
                Text(toName),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.09,
              right: width * 0.09,
              top: width * 0.04,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Transaction ID"),
                Text(transactionReferanceNumber.toString()),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.09,
              right: width * 0.09,
              top: width * 0.04,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Date and Time"),
                Row(
                  children: [
                    Text(
                      DateFormat.yMMMMd('en_US').format(dateTime).toString(),
                    ),
                    const Text(", "),
                    Text(
                      DateFormat.jm().format(dateTime).toString(),
                    ),
                  ],
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: width * 0.09,
              right: width * 0.09,
              top: width * 0.04,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Expense"),
                Text("Rs. $amount"),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.05),
            child: Container(
              width: width * 0.8,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(width * 0.03)),
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
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DetailsButton extends StatelessWidget {
  const DetailsButton({
    super.key,
    required this.width,
    required this.btnText,
    required this.icon,
  });

  final double width;
  final String btnText;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(width * 0.04),
        border: Border.all(
          width: width * 0.003,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(width * 0.03),
        child: Row(
          children: [
            icon,
            SizedBox(
              width: width * 0.03,
            ),
            Text(btnText),
          ],
        ),
      ),
    );
  }
}

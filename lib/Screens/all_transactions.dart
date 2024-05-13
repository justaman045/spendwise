import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:spendwise/Components/responsive_methods.dart";
import "package:spendwise/Components/transaction_charts.dart";
import "package:spendwise/Components/transaction_widget.dart";
import "package:spendwise/Models/cus_transaction.dart";
import "package:spendwise/Requirements/transaction.dart";

// TODO: Reduce Lines of Code
class AllTransactions extends StatefulWidget {
  const AllTransactions({
    super.key,
    required this.pageTitle,
    required this.chartTitle,
    required this.chartType,
    required this.type,
  });

  // final List<Transaction> transactioncustom;
  final String pageTitle;
  final String chartTitle;
  final String chartType;
  final String type;

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  Future? _future;

  Future<dynamic> getData() async {
    final bankTransactions = await querySmsMessages();
    return bankTransactions;
  }

  Future<void> _refreshData() async {
    setState(() {
      _future = getData();
    });
  }

  @override
  void initState() {
    _future = getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // debugPrint(transactioncustom.length.toString());
    return RefreshIndicator(
      onRefresh: () => _refreshData(),
      child: FutureBuilder(
        future: _future,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            List<CusTransaction> bankTransactions = [];
            if (widget.type.toLowerCase() == "income") {
              bankTransactions = allIncomeThisMonth(snapshot.data);
            } else if (widget.type.toLowerCase() == "expense") {
              bankTransactions = allExpenseThisMonth(snapshot.data);
            } else if (widget.type.toLowerCase() == "incomea") {
              bankTransactions = allaIncomeThisMonth(snapshot.data);
            } else if (widget.type.toLowerCase() == "expensea") {
              bankTransactions = allaExpenseThisMonth(snapshot.data);
            } else if (widget.type.toLowerCase() == "trans") {
              bankTransactions = allTransactions(snapshot.data);
            } else if (widget.type.toLowerCase() == "transmonth") {
              bankTransactions = allTransactionsThisMonth(snapshot.data);
            }
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.pageTitle,
                  style: TextStyle(fontSize: 20.r),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => {Get.back(result: "refresh")},
                ),
              ),
              body: SafeArea(
                child: bankTransactions.isEmpty
                    ? Center(
                        child: Text(
                          "No Transactions Recorded",
                          style: TextStyle(
                            fontSize: 20.r,
                          ),
                        ),
                      )
                    : Column(
                        children: [
                          TransactionCharts(
                            chartTitleCustom: widget.chartTitle,
                            chartNameOne: widget.chartType,
                            chartOne: bankTransactions,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: bankTransactions
                                  .length, // Use todaysTransactions length
                              itemBuilder: (context, index) {
                                final transaction = bankTransactions[index];
                                return TransactionWidget(
                                  expenseType: transaction.expenseType,
                                  width: getScreenWidth(context),
                                  amount: transaction.amount.toInt(),
                                  dateAndTime: transaction.dateAndTime,
                                  name: transaction.name,
                                  typeOfTransaction:
                                      transaction.typeOfTransaction,
                                  height: getScreenHeight(context),
                                  transactionReferanceNumber:
                                      transaction.transactionReferanceNumber,
                                  toIncl: transaction.toInclude,
                                );
                              },
                            ),
                          ),
                        ],
                      ),
              ),
            );
          } else {
            return const Scaffold(
              body: SafeArea(
                child: Center(child: CircularProgressIndicator()),
              ),
            );
          }
        },
      ),
    );
  }
}

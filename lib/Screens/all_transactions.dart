import "package:calendar_date_picker2/calendar_date_picker2.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:shared_preferences/shared_preferences.dart";
import "package:spendwise/Components/transaction_charts.dart";
import "package:spendwise/Components/transaction_widget.dart";
import "package:spendwise/Models/cus_transaction.dart";
import "package:spendwise/Requirements/transaction.dart";
import "package:spendwise/Utils/methods.dart";
import "package:spendwise/Utils/theme.dart";

// TODO: Reduce Lines of Code
class AllTransactions extends StatefulWidget {
  const AllTransactions({
    super.key,
    required this.pageTitle,
    required this.chartTitle,
    required this.chartType,
    this.showHidden = false,
    this.income = false,
    this.thisMonth = false,
    this.expense = false,
    this.todayTrans = false,
  });

  // final List<Transaction> transaction custom;
  final String pageTitle;
  final String chartTitle;
  final String chartType;
  final bool showHidden;
  final bool income;
  final bool thisMonth;
  final bool expense;
  final bool todayTrans;

  @override
  State<AllTransactions> createState() => _AllTransactionsState();
}

class _AllTransactionsState extends State<AllTransactions> {
  // Local Variable Declaration to use it in rendering
  List<CusTransaction> bankTransaction = [];
  dynamic username;
  DateTime endDate = DateTime.now();
  DateTime startDate = DateTime.now();
  bool filter = true;

  // Function to run everytime a user expects to refresh the data but the value is not being used
  Future<void> _refreshData() async {
    setState(() {
      getTransactions();
    });
  }

  // void _getData() async {
  //   bankTransaction = await getTransactions();
  //   setState(() {
  //     bankTransaction;
  //   });
  // }

  // Override default method to get the initial data beforehand only
  @override
  void initState() {
    _checkFirstTime(getStatus: true).then((value) => filter = value);
    super.initState();
  }

  Future<bool> _checkFirstTime({bool getStatus = false}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool filterOptions = prefs.getBool('filterOptions') ?? false;

    if(getStatus){
      return filterOptions;
    }

    // Toggle the filterOptions value
    filterOptions = !filterOptions;

    // Update SharedPreferences
    prefs.setBool('filterOptions', filterOptions);

    // Update the UI state only if filterOptions is true
    setState(() {
      filter = filterOptions;
    });

    return filterOptions;
  }

  @override
  Widget build(BuildContext context) {
    List<CusTransaction> bankTransactions = [];
    return RefreshIndicator(
      onRefresh: () => _refreshData(),
      child: FutureBuilder(
        future: getTransactions(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            bankTransactions = allTransactions(
              snapshot.data,
              todayTrans: widget.todayTrans,
              expense: widget.expense,
              income: widget.income,
              showHidden: widget.showHidden,
              thisMonth: widget.thisMonth,
            );

            bankTransactions
                .sort((b, a) => a.dateAndTime.compareTo(b.dateAndTime));
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.pageTitle,
                  style: TextStyle(fontSize: 20.r),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Get.isDarkMode
                        ? MyAppColors.normalColoredWidgetTextColorLightMode
                        : MyAppColors.normalColoredWidgetTextColorDarkMode,
                  ),
                  onPressed: () => {
                    Get.back(result: "refresh"),
                  },
                ),
                actions: [
                  IconButton(
                    onPressed: () => _checkFirstTime(),
                    icon: const Icon(CupertinoIcons.settings),
                  ),
                ],
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
                          //TODO: Add a Date Based Transaction Filtering option
                          if (!filter) ...[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    gradient: colorsOfGradient(),
                                  ),
                                  child: TextButton(
                                    onPressed: () async {
                                      var results =
                                          await showCalendarDatePicker2Dialog(
                                        context: context,
                                        config:
                                            CalendarDatePicker2WithActionButtonsConfig(
                                          firstDayOfWeek: 1,
                                          calendarType:
                                              CalendarDatePicker2Type.range,
                                          selectedDayTextStyle: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                          selectedDayHighlightColor:
                                              Colors.purple,
                                          centerAlignModePicker: true,
                                          customModePickerIcon:
                                              const SizedBox(),
                                          dayBuilder: dayBuilder(context),
                                          yearBuilder: yearBuilder(),
                                        ),
                                        dialogSize: const Size(325, 400),
                                      );
                                      if (results != null) {
                                        startDate = results[0]!;
                                        endDate = results[1]!;
                                        final filteredTransactions = snapshot
                                            .data
                                            .where((element) =>
                                                element.dateAndTime
                                                    .isAfter(startDate) &&
                                                element.dateAndTime
                                                    .isBefore(endDate))
                                            .toList();

                                        setState(() {
                                          bankTransactions =
                                              filteredTransactions;
                                        });
                                      }
                                    },
                                    child: Text(
                                        DateFormat.yMMMMd().format(startDate)),
                                  ),
                                ),
                                const Text("-"),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20.r),
                                      gradient: colorsOfGradient()),
                                  child: TextButton(
                                    onPressed: () {},
                                    child: Text(
                                        DateFormat.yMMMMd().format(endDate)),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          TransactionCharts(
                            chartTitle: widget.chartTitle,
                            chartName: widget.chartType,
                            chartData: bankTransactions.reversed.toList(),
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: bankTransactions
                                  .length, // Use todayTransactions length
                              itemBuilder: (context, index) {
                                final transaction = bankTransactions[index];
                                return TransactionWidget(
                                  expenseType: transaction.expenseType,
                                  amount: transaction.amount.toInt(),
                                  dateAndTime: transaction.dateAndTime,
                                  name: transaction.name,
                                  typeOfTransaction:
                                      transaction.typeOfTransaction,
                                  transactionReferanceNumber:
                                      transaction.transactionReferanceNumber,
                                  toIncl: transaction.toInclude,
                                  refreshData: _refreshData,
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

import "package:calendar_date_picker2/calendar_date_picker2.dart";
import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";
import "package:intl/intl.dart";
import "package:showcaseview/showcaseview.dart";
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
  // Local Variable Declaration to use it in rendering
  List<CusTransaction> bankTransaction = [];
// ignore: unused_field
  Future? _future;
  dynamic username;
  final GlobalKey _one = GlobalKey();
  DateTime startDate = DateTime.now();
  DateTime endDate = DateTime.now();

  // Function to run everytime a user expects to refresh the data but the value is not being used
  Future<void> _refreshData() async {
    setState(() {
      _future = getTransactions();
    });
  }

  // Override default method to get the initial data beforehand only
  @override
  void initState() {
    // _getData();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
        (_) => ShowCaseWidget.of(context).startShowCase([_one]));
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
            if (widget.type.toLowerCase() == "thismonthIncome".toLowerCase()) {
              bankTransactions =
                  allTransactions(snapshot.data, income: true, thisMonth: true);
            } else if (widget.type.toLowerCase() ==
                "thismonthexpense".toLowerCase()) {
              bankTransactions = allTransactions(snapshot.data,
                  expense: true, thisMonth: true);
            } else if (widget.type.toLowerCase() ==
                "withhiddenIncome".toLowerCase()) {
              bankTransactions = allTransactions(snapshot.data,
                  showHidden: true, income: true);
            } else if (widget.type.toLowerCase() ==
                "withHiddenExpense".toLowerCase()) {
              bankTransactions = allTransactions(snapshot.data,
                  expense: true, showHidden: true);
            } else if (widget.type.toLowerCase() ==
                "allTransactions".toLowerCase()) {
              bankTransactions = allTransactions(
                snapshot.data,
              );
            } else if (widget.type.toLowerCase() ==
                "thisMonthTransactions".toLowerCase()) {
              bankTransactions =
                  allTransactions(snapshot.data, thisMonth: true);
            }
            bankTransactions.sort((a,b) => a.dateAndTime.compareTo(b.dateAndTime));
            return Scaffold(
              appBar: AppBar(
                title: Text(
                  widget.pageTitle,
                  style: TextStyle(fontSize: 20.r),
                ),
                centerTitle: true,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back,
                      color: Get.isDarkMode
                          ? MyAppColors.normalColoredWidgetTextColorLightMode
                          : MyAppColors.normalColoredWidgetTextColorDarkMode),
                  onPressed: () => {
                    Get.back(result: "refresh"),
                  },
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
                          //TODO: Add a Date Based Transaction Filtering option
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    gradient: colorsOfGradient()),
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
                                        customModePickerIcon: const SizedBox(),
                                        dayBuilder: dayBuilder(context),
                                        yearBuilder: yearBuilder(),
                                      ),
                                      dialogSize: const Size(325, 400),
                                    );
                                    if (results != null) {
                                      startDate = results[0]!;
                                      endDate = results[1]!;
                                      final filteredTransactions = snapshot.data.where((element) =>
                                      element.dateAndTime.isAfter(startDate) &&
                                          element.dateAndTime.isBefore(endDate)
                                      ).toList();

                                      setState(() {
                                        bankTransactions = filteredTransactions;
                                      });
                                    }
                                    // CalendarDatePicker2(
                                    //   config: CalendarDatePicker2Config(
                                    //     calendarType: CalendarDatePicker2Type.multi,
                                    //   ),
                                    //   value: _rangeDatePickerValueWithDefaultValue,
                                    //   onValueChanged: (dates) => _rangeDatePickerValueWithDefaultValue = dates,
                                    // );
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
                                  child:
                                      Text(DateFormat.yMMMMd().format(endDate)),
                                ),
                              ),
                            ],
                          ),
                          TransactionCharts(
                            chartTitle: widget.chartTitle,
                            chartName: widget.chartType,
                            chartData: bankTransactions,
                          ),
                          Expanded(
                            child: ListView.builder(
                              itemCount: bankTransactions
                                  .length, // Use todaysTransactions length
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

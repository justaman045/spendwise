import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:spendwise/Models/people_expense.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/add_people.dart';
import 'package:spendwise/Utils/people_balance_shared_methods.dart';

//TODO: Make page a bit beautiful

class People extends StatefulWidget {
  const People({super.key});

  @override
  _PeopleState createState() => _PeopleState();
}

class _PeopleState extends State<People> {
  final _peopleBalanceList = <PeopleBalance>[];
  // ignore: unused_field
  Future? _future;

  @override
  void initState() {
    super.initState();
  }

  // Function to run everytime a user expects to refresh the data but the value is not being used
  Future<void> _refreshData() async {
    setState(() {
      _peopleBalanceList.clear();
      _future = PeopleBalanceSharedMethods().getAllPeopleBalance();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: PeopleBalanceSharedMethods().getAllPeopleBalance(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (ConnectionState.done == snapshot.connectionState) {
          if (_peopleBalanceList.length != snapshot.data.length) {
            _peopleBalanceList.clear();
            _peopleBalanceList.addAll(snapshot.data);
          }
          debugPrint(snapshot.data.length.toString());
          return RefreshIndicator(
            onRefresh: _refreshData,
            child: Scaffold(
              appBar: AppBar(
                title: const Text("Managing Balance"),
                centerTitle: true,
              ),
              body: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (snapshot.data.length > 0) ...[
                    Expanded(
                      child: ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 20.w,
                              vertical: 10.h,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(width: 1.r),
                                    borderRadius: BorderRadius.circular(20.r),
                                    color: Colors.blueGrey,
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.all(10.r),
                                    child: const Icon(Icons.payment_rounded),
                                  ),
                                ),
                                SizedBox(
                                  width: 275.w,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 20.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(snapshot.data[index].name),
                                            Row(
                                              children: [
                                                Text(snapshot
                                                    .data[index].dateAndTime),
                                                if (snapshot
                                                    .data[index].transactionFor
                                                    .toString()
                                                    .isNotEmpty) ...[
                                                  const Text(" - "),
                                                  Text(snapshot.data[index]
                                                      .transactionFor),
                                                ],
                                              ],
                                            ),
                                            if (snapshot.data[index].amount >
                                                0) ...[
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 7.h),
                                                child: SizedBox(
                                                  width: 150.w,
                                                  child: Text(
                                                      "You've to Recieve Rs. ${snapshot.data[index].amount} from ${snapshot.data[index].name}"),
                                                ),
                                              ),
                                            ] else ...[
                                              Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 7.h),
                                                child: SizedBox(
                                                  width: 150.w,
                                                  child: Text(
                                                      "You've to Give Rs. ${snapshot.data[index].amount} from ${snapshot.data[index].name}"),
                                                ),
                                              ),
                                            ],
                                          ],
                                        ),
                                        Text(
                                            "Rs. ${snapshot.data[index].amount.toString()}"),
                                        GestureDetector(
                                          onTap: () {
                                            PeopleBalanceSharedMethods()
                                                .deletePeopleBalance(snapshot
                                                    .data[index]
                                                    .transactionReferanceNumber)
                                                .then(
                                              (value) {
                                                _refreshData();
                                              },
                                            );
                                          },
                                          child: const Icon(Icons.delete),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ] else ...[
                    Center(
                      child: Column(
                        children: [
                          const Text("No Balance to settle"),
                          TextButton(
                              onPressed: () {
                                _refreshData();
                              },
                              child: const Text("Click Here to referesh"))
                        ],
                      ),
                    )
                  ]
                ],
              ),

              // a floating action button to add the cash entry
              floatingActionButton: FloatingActionButton.extended(
                label: const Icon(Icons.add),
                onPressed: () async {
                  final toreload = await Get.to(
                    routeName: "add_people",
                    () => const AddPeople(),
                    curve: customCurve,
                    transition: customTrans,
                    duration: duration,
                  );

                  if (toreload != null) {
                    // debugPrint(toreload.toString());
                    _refreshData();
                  }
                },
              ),
            ),
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

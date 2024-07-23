import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendwise/Models/people_expense.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/add_people.dart';
import 'package:spendwise/Utils/people_balance_shared_methods.dart';

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
    _fetchData();
  }

  Future<List<PeopleBalance>> _fetchData() async {
    _peopleBalanceList.clear();
    _peopleBalanceList
        .addAll(await PeopleBalanceSharedMethods().getAllPeopleBalance());
    return _peopleBalanceList;
  }

  // Function to run everytime a user expects to refresh the data but the value is not being used
  Future<void> _refreshData() async {
    setState(() {
      _future = _fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _fetchData(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (ConnectionState.done == snapshot.connectionState) {
          return Scaffold(
            appBar: AppBar(
              title: const Text("Managing Balance"),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _peopleBalanceList.length,
                    itemBuilder: (context, index) {
                      return Text(_peopleBalanceList[index].name);
                    },
                  ),
                )
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

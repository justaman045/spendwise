import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/Requirements/data.dart';

class EditUserProfile extends StatelessWidget {
  const EditUserProfile(
      {super.key, required this.name, required this.designation});

  final String name;
  final String designation;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    final double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Profile"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: height * 0.04),
            child: Center(
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromRGBO(210, 209, 254, 1),
                            Color.fromRGBO(243, 203, 237, 1),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(width * 0.5)),
                    width: width * 0.35,
                    height: height * 0.16,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.08),
            child: TextFormField(
              initialValue: name,
              decoration: const InputDecoration(
                label: Text("Name"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.08, vertical: height * 0.01),
            child: TextFormField(
              initialValue: designation,
              decoration: const InputDecoration(
                label: Text("Designation"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.08, vertical: height * 0.01),
            child: TextFormField(
              initialValue: emailId,
              decoration: const InputDecoration(
                label: Text("Email ID"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.08, vertical: height * 0.01),
            child: TextFormField(
              initialValue: userName,
              decoration: const InputDecoration(
                label: Text("Username"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: width * 0.08, vertical: height * 0.01),
            child: TextFormField(
              obscureText: true,
              initialValue: password,
              decoration: const InputDecoration(
                label: Text("Password"),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.04),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  width: width * 0.3,
                  height: height * 0.05,
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
                  child: const Center(child: Text("Save Changes")),
                ),
                Container(
                  width: width * 0.3,
                  height: height * 0.05,
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
                  child: const Center(child: Text("Save Changes")),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: width * 0.1, top: height * 0.01),
            child: Row(
              children: [
                Text(
                    "Date Joined ${DateFormat.yMMMd().format(DateTime.now())}"),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

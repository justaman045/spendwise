import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:spendwise/Requirements/data.dart';

class EditUserProfile extends StatelessWidget {
  const EditUserProfile(
      {super.key, required this.name, required this.designation});

  final String name;
  final String designation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: TextStyle(fontSize: 20.r),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 30.h),
              child: Center(
                child: Stack(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromRGBO(210, 209, 254, 1),
                            Color.fromRGBO(243, 203, 237, 1),
                          ],
                        ),
                      ),
                      width: 150.w,
                      height: 150.h,
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25.w),
              child: SizedBox(
                height: 60.h,
                child: TextFormField(
                  initialValue: name,
                  style: TextStyle(fontSize: 15.r),
                  decoration: InputDecoration(
                    label: Text(
                      "Name",
                      style: TextStyle(fontSize: 15.r),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 10.h,
              ),
              child: SizedBox(
                height: 60.h,
                child: TextFormField(
                  style: TextStyle(fontSize: 15.r),
                  initialValue: designation,
                  decoration: InputDecoration(
                    label: Text(
                      "Designation",
                      style: TextStyle(fontSize: 15.r),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 10.h,
              ),
              child: SizedBox(
                height: 60.h,
                child: TextFormField(
                  style: TextStyle(fontSize: 15.r),
                  initialValue: emailId,
                  decoration: InputDecoration(
                    label: Text(
                      "Email ID",
                      style: TextStyle(fontSize: 15.r),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 25.w,
                vertical: 10.h,
              ),
              child: SizedBox(
                height: 60.h,
                child: TextFormField(
                  style: TextStyle(fontSize: 15.r),
                  initialValue: userName,
                  decoration: InputDecoration(
                    label: Text(
                      "Username",
                      style: TextStyle(fontSize: 15.r),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 150.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromRGBO(210, 209, 254, 1),
                          Color.fromRGBO(243, 203, 237, 1),
                        ],
                      ),
                    ),
                    child: Center(
                        child: Text(
                      "Save Changes",
                      style: TextStyle(fontSize: 15.r),
                    )),
                  ),
                  Container(
                    width: 150.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromRGBO(210, 209, 254, 1),
                          Color.fromRGBO(243, 203, 237, 1),
                        ],
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Discard Changes",
                        style: TextStyle(fontSize: 15.r),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: SizedBox.expand(
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: Row(
                    children: [
                      Text(
                        "Date Joined ${DateFormat.yMMMd().format(DateTime.now())}",
                        style: TextStyle(fontSize: 15.r),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

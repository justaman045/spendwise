import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

final _formKey = GlobalKey<FormState>();

class EditUserProfile extends StatefulWidget {
  const EditUserProfile({super.key});

  @override
  State<EditUserProfile> createState() => _EditUserProfileState();
}

class _EditUserProfileState extends State<EditUserProfile> {
  @override
  Widget build(BuildContext context) {
    TextEditingController nameEditingController = TextEditingController();
    TextEditingController dreamEditingController = TextEditingController();
    TextEditingController emailEditingController = TextEditingController();
    TextEditingController usernameEditingController = TextEditingController();
    // TextEditingController passwordEditingController = TextEditingController();
    return FutureBuilder(
      future: FirebaseFirestore.instance.collection("Users").get(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          dynamic user;
          for (dynamic use in snapshot.data.docs) {
            if (use["email"].toString() ==
                FirebaseAuth.instance.currentUser!.email) {
              user = use;
            }
          }
          nameEditingController.text = user["name"];
          dreamEditingController.text = user["dreamToSave"];
          emailEditingController.text = user["email"];
          usernameEditingController.text = user["username"];
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
                  Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 25.w),
                          child: SizedBox(
                            height: 60.h,
                            child: TextFormField(
                              controller: nameEditingController,
                              validator: (value) {
                                if (value!.length < 4) {
                                  return "Name must be atleast 4 Charecters";
                                }
                                return null;
                              },
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
                              controller: dreamEditingController,
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (int.parse(value!) > 10000000000 ||
                                    int.parse(value) < 50) {
                                  return "Amount to Save must be between 50 - 10000000000";
                                }
                                return null;
                              },
                              style: TextStyle(fontSize: 15.r),
                              decoration: InputDecoration(
                                label: Text(
                                  "Dream to Save the amount of",
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
                              controller: emailEditingController,
                              style: TextStyle(fontSize: 15.r),
                              validator: (value) {
                                if (!value!.contains("@")) {
                                  return "Enter correct email";
                                } else if (RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                    .hasMatch(emailEditingController.text)) {
                                  return null;
                                }
                                return "Please Enter correct Email ID";
                              },
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
                              controller: usernameEditingController,
                              style: TextStyle(fontSize: 15.r),
                              validator: (value) {
                                if (value!.isNotEmpty) {
                                  if (value.length < 6) {
                                    return "Select a different Username";
                                  }
                                } else {
                                  return "Enter some value";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                label: Text(
                                  "Username",
                                  style: TextStyle(fontSize: 15.r),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        GestureDetector(
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              // final user = FirebaseAuth.instance.currentUser;
                              // showDialog(
                              //   context: context,
                              //   builder: (context) => AlertDialog(
                              //     actions: [
                              //       TextButton(
                              //           onPressed: () {
                              //             Navigator.of(context).pop(
                              //                 passwordEditingController.text);
                              //           },
                              //           child: const Text("Submit"))
                              //     ],
                              //     title:
                              //         const Text("Enter Password to Confirm"),
                              //     content: TextField(
                              //       controller: passwordEditingController,
                              //     ),
                              //   ),
                              // );
                              // final credential = EmailAuthProvider.credential(
                              //     email: emailEditingController.text,
                              //     password: passwordEditingController.text);
                              // await user!
                              //     .reauthenticateWithCredential(credential);
                              // await user?.verifyBeforeUpdateEmail(
                              //     emailEditingController.text);
                              await FirebaseFirestore.instance
                                  .collection("Users")
                                  .doc(FirebaseAuth.instance.currentUser!.uid)
                                  .update({
                                    "name": nameEditingController.text,
                                    "username": usernameEditingController.text,
                                    "dreamToSave": dreamEditingController.text
                                  })
                                  .then((value) => Get.back())
                                  .then((value) => Get.back());
                            }
                          },
                          child: Container(
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
                              "Date Joined ${DateFormat.yMMMd().format(user["dateOfJoining"].toDate())}",
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
        } else {
          return const Scaffold(
            body: SafeArea(
              child: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }
}

import "package:flutter/material.dart";
import "package:flutter_screenutil/flutter_screenutil.dart";
import "package:get/get.dart";

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: 150.h,
                width: 150.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(150.r),
                  ),
                  gradient: const LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromRGBO(210, 209, 254, 1),
                      Color.fromRGBO(243, 203, 237, 1),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    height: 200.h,
                    width: 120.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(150.r),
                        bottomLeft: Radius.circular(150.r),
                      ),
                      gradient: const LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [
                          Color.fromRGBO(210, 209, 254, 1),
                          Color.fromRGBO(243, 203, 237, 1),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: 100.h,
                        left: 20.w,
                      ),
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: 30.r,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        top: 10.h,
                        right: 20.w,
                      ),
                      child: Text(
                        "Reset your Password, via your Email Address. Just Enter your Emal and we'll send you a Password Reset Link",
                        style: TextStyle(fontSize: 13.r),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: 20.w,
                        top: 20.h,
                        right: 20.w,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: const Text("Enter you Email Account"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 50.h,
                        right: 20.w,
                      ),
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                gradient: LinearGradient(
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                  colors: [
                                    Colors.blue.shade400,
                                    Colors.blue.shade600,
                                  ],
                                ),
                              ),
                              width: 150.w,
                              height: 45.h,
                              child: Center(
                                child: Text(
                                  "Send me the Link",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.r,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 100.r),
                      child: Stack(
                        children: [
                          Container(
                            height: 150.h,
                            width: 80.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(300.r),
                                topRight: Radius.circular(300.r),
                              ),
                              gradient: const LinearGradient(
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                                colors: [
                                  Color.fromRGBO(210, 209, 254, 1),
                                  Color.fromRGBO(243, 203, 237, 1),
                                ],
                              ),
                            ),
                          ),
                          Positioned(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Container(
                                  height: 180.h,
                                  width: 100.w,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(300.r),
                                      bottomLeft: Radius.circular(300.r),
                                    ),
                                    gradient: const LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Color.fromRGBO(210, 209, 254, 1),
                                        Color.fromRGBO(243, 203, 237, 1),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 20.h,
                            child: Padding(
                              padding: EdgeInsets.only(left: 75.w),
                              child: GestureDetector(
                                onTap: () => Get.back(),
                                child: Container(
                                  width: 200.w,
                                  height: 50.h,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.r),
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.blue.shade400,
                                        Colors.blue.shade600,
                                      ],
                                    ),
                                  ),
                                  child: Center(
                                    child: Text(
                                      "Go Back",
                                      style: TextStyle(
                                        fontSize: 15.r,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

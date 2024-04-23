import "package:flutter/material.dart";
import "package:get/get.dart";

class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            children: [
              Container(
                height: height * 0.2,
                width: width * 0.5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomRight: Radius.circular(height * 0.3),
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
              Padding(
                padding: EdgeInsets.only(left: width * 0.65),
                child: Container(
                  height: height * 0.3,
                  width: width * 0.35,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(height * 0.3),
                      bottomLeft: Radius.circular(height * 0.3),
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
              ),
              SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.15,
                        left: width * 0.05,
                      ),
                      child: Text(
                        "Reset Password",
                        style: TextStyle(
                          fontSize: height * 0.04,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.05,
                        top: height * 0.03,
                      ),
                      child: Text(
                        "Reset your Password, via your Email Address. Just Enter your Emal and we'll send you a Password Reset Link",
                        style: TextStyle(fontSize: height * 0.017),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        left: width * 0.06,
                        top: height * 0.03,
                        right: width * 0.06,
                      ),
                      child: TextFormField(
                        decoration: InputDecoration(
                          label: const Text("Enter you Email Account"),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(width * 0.04),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: height * 0.05, left: width * 0.55),
                      child: GestureDetector(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(width * 0.04),
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Colors.blue.shade400,
                                Colors.blue.shade600,
                              ],
                            ),
                          ),
                          width: width * 0.4,
                          height: height * 0.06,
                          child: Center(
                            child: Text(
                              "Send me the Link",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: width * 0.037,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: height * 0.1),
                      child: Stack(
                        children: [
                          Container(
                            height: height * 0.2,
                            width: width * 0.2,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(height * 0.3),
                                topRight: Radius.circular(height * 0.3),
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
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.65),
                              child: Container(
                                height: height * 0.3,
                                width: width * 0.35,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(height * 0.3),
                                    bottomLeft: Radius.circular(height * 0.3),
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
                            ),
                          ),
                          Positioned(
                            bottom: height * 0.04,
                            child: Padding(
                              padding: EdgeInsets.only(left: width * 0.25),
                              child: GestureDetector(
                                onTap: () => Get.back(),
                                child: Container(
                                  width: width * 0.5,
                                  height: height * 0.08,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.circular(width * 0.04),
                                    gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                        Colors.blue.shade400,
                                        Colors.blue.shade600,
                                      ],
                                    ),
                                  ),
                                  child: const Center(
                                    child: Text(
                                      "Go Back",
                                      style: TextStyle(
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

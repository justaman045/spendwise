import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:spendwise/Components/available_balance.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/home_page.dart';
import 'package:spendwise/Screens/intro.dart';
import 'package:spendwise/Utils/theme.dart';
import 'package:get/get.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  bool _isSendingEmail = false;
  bool _isCheckingStatus = false;

  Future<void> checkAndRedirect() async {
    User? user = FirebaseAuth.instance.currentUser;
    setState(() {
      _isCheckingStatus = true;
    });
    await user?.reload();
    if (user!.emailVerified) {
      debugPrint("Email Verified");
      Get.snackbar("Account Confirmed", "Redirecting you to the Home Page");
      Get.offAll(
        routeName: routes[3],
            () => const HomePage(),
        transition: customTrans,
        curve: customCurve,
        duration: duration,
      );
    } else {
      setState(() {
        _isCheckingStatus = false;
      });
      debugPrint("Email Not Verfied");
      Get.snackbar("Account Not Confirmed", "Resend it again to confirm");
    }
  }

  @override
  void initState() {
    checkAndRedirect(); // Check verification status on page load
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    Future<void> sendConfirmationMail() async {
      setState(() {
        _isSendingEmail = true;
      });
      await user?.sendEmailVerification();
      setState(() {
        _isSendingEmail = false;
      });
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Verify Email"), centerTitle: true,),
      body: Column(
        children: [
          SizedBox(height: 30.h,),
          Center(child: Icon(Icons.mark_email_unread_rounded, size: 40.r,),),
          SizedBox(height: 30.h,),
          Text("Verify your Email", style: TextStyle(fontSize: 30.r,),),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 20.h),
            child: Text("We have recently sent you a confirmation Mail, click on the Confirmation link that is Sent over mail to your Email ID.", style: TextStyle(fontSize: 15.r,),),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Container(decoration: BoxDecoration(gradient: colorsOfGradient(), borderRadius: BorderRadius.all(Radius.circular(10.r))), child: TextButton(onPressed: _isSendingEmail ? null : sendConfirmationMail, child: _isSendingEmail ? const CircularProgressIndicator() : const Text("Re-send Confirmation mail"))),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Container(decoration: BoxDecoration(gradient: colorsOfGradient(), borderRadius: BorderRadius.all(Radius.circular(10.r))), child: TextButton(onPressed: _isCheckingStatus ? null : checkAndRedirect, child: _isCheckingStatus ? const CircularProgressIndicator() : const Text("Check Status for Account Confirmation"))),
          ),
          Padding(
            padding: EdgeInsets.all(20.r),
            child: Container(
              decoration: BoxDecoration(
                gradient: colorsOfGradient(),
                borderRadius: BorderRadius.all(Radius.circular(10.r)),
              ),
              child: TextButton(
                onPressed: _isCheckingStatus
                    ? null
                    : () async {
                  await FirebaseAuth.instance.signOut();
                  debugPrint("Signed out");
                  Get.offAll(routeName: routes[0],
                        () => const Intro(),
                    transition: customTrans,
                    curve: customCurve,
                    duration: duration,);
                },
                child: _isCheckingStatus
                    ? const CircularProgressIndicator()
                    : const Text("Log-Out Account"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
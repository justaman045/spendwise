import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/home_page.dart';
import 'package:spendwise/Screens/intro.dart';
import 'package:spendwise/Screens/login.dart';
import 'package:spendwise/Screens/signup.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const SpendWise());
}

class SpendWise extends StatefulWidget {
  const SpendWise({super.key});

  @override
  State<SpendWise> createState() => _SpendWiseState();
}

class _SpendWiseState extends State<SpendWise> {
  List<SmsMessage> messages = [];

  dynamic currentUser;
  dynamic message;

  @override
  void initState() {
    super.initState();
    _requestSmsPermission();
  }

  Future<void> _requestSmsPermission() async {
    if (await Permission.sms.request().isGranted) {
      final tcurrentUser = FirebaseAuth.instance.currentUser;
      if (tcurrentUser != null) {
        setState(() {
          currentUser = tcurrentUser;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      builder: (_, child) {
        return GetMaterialApp(
          title: "SpendWise",
          debugShowCheckedModeBanner: false,
          routes: {
            routes[0]: (context) => const Intro(),
            routes[1]: (context) => const Login(),
            routes[2]: (context) => const SignUp(),
            routes[3]: (context) => const HomePage(),
          },
          home: currentUser != null ? const HomePage() : const Intro(),
        );
      },
    );
  }
}

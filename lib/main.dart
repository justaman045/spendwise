import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/home_page.dart';
import 'package:spendwise/Screens/intro.dart';
import 'package:spendwise/Screens/login.dart';
import 'package:spendwise/Screens/signup.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';

void main() {
  runApp(const SpendWise());
}

class SpendWise extends StatefulWidget {
  const SpendWise({super.key});

  @override
  State<SpendWise> createState() => _SpendWiseState();
}

class _SpendWiseState extends State<SpendWise> {
  final SmsQuery query = SmsQuery();
  List<SmsMessage> messages = [];

  @override
  void initState() {
    super.initState();
    _requestSmsPermission();
  }

  Future<void> _requestSmsPermission() async {
    if (await Permission.sms.request().isGranted) {
      _querySmsMessages();
    }
  }

  Future<void> _querySmsMessages() async {
    final message = await query.querySms(
      kinds: [
        SmsQueryKind.inbox,
        SmsQueryKind.sent,
      ],
      count: 50000,
    );
    debugPrint('sms inbox messages: ${message.length}');

    setState(() => messages = message);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "SpendWise",
      debugShowCheckedModeBanner: false,
      routes: {
        routes[0]: (context) => Intro(
              bankTransaction: messages,
            ),
        routes[1]: (context) => Login(
              bankTransaction: messages,
            ),
        routes[2]: (context) => SignUp(
              bankTransaction: messages,
            ),
        routes[3]: (context) => HomePage(
              bankTransaction: messages,
            ),
      },
      home: loggedin
          ? HomePage(
              bankTransaction: messages,
            )
          : Intro(
              bankTransaction: messages,
            ),
    );
  }
}

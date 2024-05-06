import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Requirements/transaction.dart';
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
  final SmsQuery query = SmsQuery();
  List<SmsMessage> messages = [];
  List<Transaction> transactions = [];
  dynamic currentUser;

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

    transactions = transactionss;

    // ------------------------------------------------Area to test my Code----------------------------------

    final filteredMessages = filterBankTransactions(message);

    // filteredMessages.forEach((element) {
    //   // debugPrint(element.date.toString());
    //   debugPrint(element.body);
    // });

    final testTrans = parseBankTransactions(filteredMessages);
    // ------------------------------------------------Area to test my Code----------------------------------

    final tcurrentUser = await FirebaseAuth.instance.currentUser;
    debugPrint(tcurrentUser.toString());
    if (tcurrentUser != null) {
      setState(() {
        currentUser = tcurrentUser;
      });
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
            routes[0]: (context) => Intro(
                  bankTransaction: transactions,
                ),
            routes[1]: (context) => Login(
                  bankTransaction: transactions,
                ),
            routes[2]: (context) => SignUp(
                  bankTransaction: transactions,
                ),
            routes[3]: (context) => HomePage(
                  bankTransaction: transactions,
                ),
          },
          home: currentUser != null
              ? HomePage(bankTransaction: transactions)
              : Intro(
                  bankTransaction: transactions,
                ),
        );
      },
    );
  }
}

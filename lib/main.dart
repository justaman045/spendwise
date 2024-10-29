import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:spendwise/Models/db_helper.dart';
import 'package:spendwise/Requirements/data.dart';
import 'package:spendwise/Screens/cash_entry.dart';
import 'package:spendwise/Screens/home_page.dart';
import 'package:spendwise/Screens/intro.dart';
import 'package:flutter_sms_inbox/flutter_sms_inbox.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:spendwise/Screens/verify_email.dart';
import 'package:spendwise/Utils/methods.dart';
import 'package:spendwise/Utils/theme.dart';
import 'package:spendwise/api/firebase_api.dart';
import 'firebase_options.dart';
import 'package:flutter/services.dart';

final navigatorKey = GlobalKey<NavigatorState>();

// Main function to run all the app
void main() async {
  // Firebase ensure initialized
  WidgetsFlutterBinding.ensureInitialized();

  const ScreenUtilInit();

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  ); // To turn off landscape mode

  // for SQLIte Database to create or open
  final databaseHelper = DatabaseHelper();

  // create a connection to that database
  await databaseHelper.database;

  // Firebase initialize the app within device
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FirebaseApi().initNotification();

  // Initializing Theme Controller
  Get.put(ThemeModeController());

  // run the App
  runApp(const SpendWise());
}

class SpendWise extends StatefulWidget {
  const SpendWise({super.key});

  @override
  State<SpendWise> createState() => _SpendWiseState();
}

class _SpendWiseState extends State<SpendWise> {
  // create the local variables for usage of the app
  List<SmsMessage> messages = [];
  late User currentUser;

  @override
  void initState() {
    super.initState();

    // get Android SMS request
    _requestSmsPermission();
  }

  Future<void> _requestSmsPermission() async {
    // If the app permission is not granted then request it again
    if (await Permission.sms.request().isGranted) {
      // if the user is logged in then get user session
      final tcurrentUser = FirebaseAuth.instance.currentUser;

      // get the current user that is already logged in and then if it is not
      // null then update the currentUser
      if (tcurrentUser != null) {
        setState(() {
          currentUser = tcurrentUser;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    bool loggedIn = true;

    if (FirebaseAuth.instance.currentUser != null) {
      currentUser = FirebaseAuth.instance.currentUser!;
    } else {
      loggedIn = false;
    }

    // ScreenUtilInit to initialize the Get package
    return ScreenUtilInit(
      builder: (_, child) {
        // the normal flutter app
        return GetMaterialApp(
          title: appName,
          debugShowCheckedModeBanner: false,
          routes: {
            AddCashEntry.route: (context) => const AddCashEntry(),
          },
          // theme: Get.find<ThemeModeController>().themeMode == ThemeMode.light
          //     ? MyAppThemes.lightTheme
          //     : MyAppThemes.darkTheme,
          themeMode: ThemeMode.system,
          darkTheme: MyAppThemes.darkTheme,

          // if the user is logged in then show the homepage
          // else show Intro Page
          home: loggedIn
              ? (currentUser.emailVerified
                  ? const HomePage()
                  : const VerifyEmail())
              : const Intro(),
        );
      },
    );
  }
}

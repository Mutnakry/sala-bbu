import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sala_bu/screen/app_dashboard.dart';
import 'package:sala_bu/screen/userlogin.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final SharedPreferences sp = await SharedPreferences.getInstance();
  final bool checkLoggedIn = sp.getBool("IS_LOGGEDIN") ?? false;
  runApp(HomeApp(isLoggedIn: checkLoggedIn));
  configLoading();
}


class HomeApp extends StatelessWidget {
  final bool isLoggedIn;

  const HomeApp({Key? key, required this.isLoggedIn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Login Users",
      home: isLoggedIn ? const AppDashboard() : const LoginScreen(),
      builder: EasyLoading.init(),
    );
  }
}


void configLoading() {
  EasyLoading.instance
    ..displayDuration = const Duration(milliseconds: 2000)
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..loadingStyle = EasyLoadingStyle.dark
    ..indicatorSize = 45.0
    ..radius = 10.0
    ..progressColor = Colors.yellow
    ..backgroundColor = Colors.green
    ..indicatorColor = Colors.yellow
    ..textColor = Colors.yellow
    ..maskColor = Colors.blue.withOpacity(0.5)
    ..userInteractions = true
    ..dismissOnTap = false;
}

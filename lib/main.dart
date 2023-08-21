import 'package:flutter/material.dart';
import 'package:iti_final_project/layout/home_layout.dart';
import 'package:iti_final_project/login/login_screen.dart';
import 'package:iti_final_project/on_boarding/on_boarding_screen.dart';
import 'package:iti_final_project/shared/cache_helper.dart';
import 'package:iti_final_project/shared/constants.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CacheHelper.init();
  Widget? widget;
  bool? onBoarding = CacheHelper.getData(key: 'onBoarding') ;
  token = CacheHelper.getData(key: 'token') ?? '';
  email = CacheHelper.getData(key: 'email') ?? '';

  if (onBoarding != null) {
    if (token != '') {
      widget = const HomeLayout();
    } else {
      widget = const LoginScreen();
    }
  } else {
    widget = const OnBoardingScreen();
  }

  runApp(MyApp(
    startWidget: widget,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.startWidget});
  final Widget startWidget;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultTheme,
      home: startWidget,
    );
  }
}

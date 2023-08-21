import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iti_final_project/login/login_screen.dart';
import 'package:iti_final_project/shared/cache_helper.dart';

String token = '';
int id = 1 ;

String email = '';
const defaultColor = Colors.blue;

void logOut(context) {
  CacheHelper.removeData(key: 'token').then((value) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  });
  CacheHelper.removeData(key: 'email');
  token ='';
  email = '';
}



Future<bool?> toast({required String msg , required ToastState state }) => Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastState {success , error , warning}

Color chooseToastColor(ToastState state){
  Color color;
  switch (state){
    case ToastState.success:
      color = Colors.green;
      break;
    case ToastState.error:
      color = Colors.red;
      break;
    case ToastState.warning:
      color= Colors.amber;
      break;
  }
  return color;
}

ThemeData defaultTheme = ThemeData(
  primarySwatch: defaultColor,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    titleSpacing: 20,
    color: Colors.white,
    elevation: 0,
    centerTitle: false,
    systemOverlayStyle: SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  ),
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    type: BottomNavigationBarType.fixed,
    selectedItemColor: defaultColor,
    elevation: 20,
  ),
  textTheme: const TextTheme(
      labelMedium: TextStyle(
          fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black)),
);


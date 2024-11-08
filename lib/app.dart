import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/splash_screen.dart';
import 'package:taskmanager/ui/utils/app_colors.dart';

class Taskmanagerapp extends StatelessWidget {
  const Taskmanagerapp({super.key});

  static GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Taskmanagerapp.navigatorkey,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        colorSchemeSeed: AppColor.BackgroungClr,
        textTheme: const TextTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.BackgroungClr,
          foregroundColor: AppColor.btnbackground,
          padding: EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 10,
          ),
          fixedSize: Size.fromWidth(double.maxFinite),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          )),
    );
  }

  InputDecorationTheme _inputDecorationTheme() {
    return InputDecorationTheme(
      fillColor: Colors.white,
      filled: true,
      enabledBorder: _inputBorder(),
      border: _inputBorder(),
      errorBorder: _inputBorder(),
      focusedBorder: _inputBorder(),
    );
  }

  OutlineInputBorder _inputBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: BorderSide.none,
    );
  }
}

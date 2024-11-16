import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:taskmanager/controller_binder.dart';
import 'package:taskmanager/ui/screens/forgot_password_otp_screen.dart';
import 'package:taskmanager/ui/screens/main_bottom_navbar_screen.dart';
import 'package:taskmanager/ui/screens/signin_screen.dart';
import 'package:taskmanager/ui/screens/splash_screen.dart';
import 'package:taskmanager/ui/utils/app_colors.dart';

class Taskmanagerapp extends StatelessWidget {
  const Taskmanagerapp({super.key});

  static GlobalKey<NavigatorState> navigatorkey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: Taskmanagerapp.navigatorkey,
      debugShowMaterialGrid: false,
      theme: ThemeData(
        colorSchemeSeed: AppColor.BackgroungClr,
        textTheme: const TextTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        elevatedButtonTheme: _elevatedButtonThemeData(),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      initialBinding: ControllerBinder(),
      routes: {
        SplashScreen.name : (context) => const SplashScreen(),
        MainBottomNavbarScreen.name : (context) => const MainBottomNavbarScreen(),
        SignInScreen.name : (context) => const SignInScreen(),
        ForgotPasswordOTPScreen.name : (context) => ForgotPasswordOTPScreen(email: Get.arguments),
      },
    );
  }

  ElevatedButtonThemeData _elevatedButtonThemeData() {
    return ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
          backgroundColor: AppColor.BackgroungClr,
          foregroundColor: AppColor.btnbackground,
          padding: const EdgeInsets.symmetric(
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

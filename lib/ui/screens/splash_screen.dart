import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lottie/lottie.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';
import 'package:taskmanager/ui/screens/main_bottom_navbar_screen.dart';
import 'package:taskmanager/ui/screens/signin_screen.dart';
import '../utils/assets_path.dart';
import '../widgets/Screenbackground.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _movetonextscreen();
  }

  Future<void> _movetonextscreen() async {
    await Future.delayed(const Duration(seconds: 2));
    await AuthController.getAccessToken();

    if (AuthController.isLoggedIn()) {
      await AuthController.getUserData();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (contex) => const MainBottomNavbarScreen(),
        ),
      );
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (contex) => const SignInScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: background(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(Assetspath.splashScreenicon),

              // SvgPicture.asset(
              //   Assetspath.logosvg,
              //   width: 200,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

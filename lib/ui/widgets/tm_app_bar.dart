import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:taskmanager/ui/controller/auth_controller.dart';
import 'package:taskmanager/ui/screens/profile_screen.dart';
import 'package:taskmanager/ui/screens/signin_screen.dart';

import 'package:taskmanager/ui/utils/app_colors.dart';
import 'package:taskmanager/ui/utils/assets_path.dart';

class TMAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TMAppBar({
    super.key,
    this.isProfileScreenOpen = false,
  });

  final bool isProfileScreenOpen;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (isProfileScreenOpen) {
          return;
        }
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const ProfileScreen(),
          ),
        );
      },
      child: AppBar(
        flexibleSpace: Container(
          height: 120.0,
          decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.blueAccent,
                  Colors.indigoAccent.shade400,
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.elliptical(20, 20))),
        ),
        title: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.white,
              radius: 20,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AuthController.userData?.fullName ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  Text(
                    AuthController.userData?.email ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: () async {
                await AuthController.clearUserData();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (builder) => const SignInScreen()),
                  (predicate) => false,
                );
              },
              icon: _buildLottieIcon(Assetspath.logoutIcon),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildLottieIcon(String assetPath) {
    return Lottie.asset(
      assetPath,
      width: 35,
      height: 35,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
      80.0); // Make sure the AppBar height is as large as the flexibleSpace
// @override
// Size get preferredSize => const Size.fromHeight(kToolbarHeight);
//todo ktoolbar er bepare porte oibo
}

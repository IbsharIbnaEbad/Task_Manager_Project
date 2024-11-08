import 'package:flutter/material.dart';
import 'package:taskmanager/ui/screens/cancelled_task_screen.dart';
import 'package:taskmanager/ui/screens/completed_task_screen.dart';
import 'package:taskmanager/ui/screens/new_task_screen.dart';
import 'package:taskmanager/ui/screens/progress_task_screen.dart';
import 'package:lottie/lottie.dart';

import 'package:taskmanager/ui/utils/assets_path.dart';
import 'package:taskmanager/ui/widgets/tm_app_bar.dart';

class MainBottomNavbarScreen extends StatefulWidget {
  const MainBottomNavbarScreen({super.key});

  @override
  State<MainBottomNavbarScreen> createState() => _MainBottomNavbarScreenState();
}

class _MainBottomNavbarScreenState extends State<MainBottomNavbarScreen> {
  int _seletedIndex = 0;
  final List<Widget> _screens = const [
    NewTaskScreen(),
    CompleteTaskScreen(),
    CancelledTaskScreen(),
    ProgressTaskScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TMAppBar(),
      body: _screens[_seletedIndex],
      bottomNavigationBar: NavigationBar(
        //todo : bottom navigation bar and navigation bar same e meterialdesign 3 pattern ana hoiche , navigationbar updated version
        selectedIndex: _seletedIndex,
        onDestinationSelected: (int index) {
          _seletedIndex = index;
          setState(() {});
        },

        destinations: [
           NavigationDestination(
             icon: _buildLottieIcon(Assetspath.newIcon),
            label: 'new',
          ),
          NavigationDestination(
            icon: _buildLottieIcon(Assetspath.completeIcon),
            label: 'completed',
          ),
          NavigationDestination(
            icon: _buildLottieIcon(Assetspath.cancelIcon),
            label: 'Cancelled ',
          ),
           NavigationDestination(
             icon: _buildLottieIcon(Assetspath.progressIcon),

             label: 'Progress',
          ),
        ],
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
}

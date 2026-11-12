import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app_ui/constants/number_constant.dart';
import 'package:social_media_app_ui/presentation/widgets/app_bottom_nav_bar.dart';

class MainShell extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          navigationShell,
          Positioned(
            left: NumberConstant.bottomNavHorizontalInset,
            right: NumberConstant.bottomNavHorizontalInset,
            bottom: NumberConstant.bottomNavBottomInset + MediaQuery.paddingOf(context).bottom,
            child: AppBottomNavBar(
              selectedIndex: navigationShell.currentIndex,
              onSelected: (index) => navigationShell.goBranch(index, initialLocation: index == navigationShell.currentIndex),
            ),
          ),
        ],
      ),
    );
  }
}

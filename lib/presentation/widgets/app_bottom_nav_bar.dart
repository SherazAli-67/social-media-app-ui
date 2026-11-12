import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_app_ui/constants/number_constant.dart';
import 'package:social_media_app_ui/core/app_colors.dart';
import 'package:social_media_app_ui/core/asset_res.dart';

class AppBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onSelected;

  const AppBottomNavBar({super.key, required this.selectedIndex, required this.onSelected});

  static const icons = [
    AssetRes.icHome,
    AssetRes.icNavigation,
    AssetRes.icFavorite,
    AssetRes.icProfile,
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: .circular(NumberConstant.bottomNavRadius),
        boxShadow: [BoxShadow(color: AppColors.blackColor.withValues(alpha: 0.13), offset: Offset(0, 9), blurRadius: 24)],
      ),
      child: ClipRRect(
        borderRadius: .circular(NumberConstant.bottomNavRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: NumberConstant.bottomNavBlur, sigmaY: NumberConstant.bottomNavBlur),
          child: Container(
            decoration: BoxDecoration(color: AppColors.bottomNavBg, borderRadius: .circular(NumberConstant.bottomNavRadius)),
            padding: .symmetric(horizontal: NumberConstant.bottomNavHorizontalPadding, vertical: NumberConstant.bottomNavVerticalPadding),
            child: Row(
              mainAxisAlignment: .spaceBetween,
              children: [for (var i = 0; i < icons.length; i++) _buildNavItem(index: i, icon: icons[i])],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({required int index, required String icon}) {
    final isSelected = selectedIndex == index;
    return GestureDetector(
      onTap: () => onSelected(index),
      child: DecoratedBox(
        decoration: BoxDecoration(color: isSelected ? AppColors.whiteColor : null, shape: .circle),
        child: Padding(
          padding: .all(NumberConstant.bottomNavItemPadding),
          child: SvgPicture.asset(icon, colorFilter: .mode(isSelected ? AppColors.blackColor : AppColors.whiteColor, .srcIn),),
        ),
      ),
    );
  }
}

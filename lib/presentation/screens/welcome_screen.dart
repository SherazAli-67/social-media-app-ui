import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app_ui/constants/string_const.dart';
import 'package:social_media_app_ui/core/app_textstyles.dart';
import 'package:social_media_app_ui/routing/router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: GestureDetector(
          onTap: () => context.go(NamedRoutes.home.routeName),
          child: Text(StringConst.letsStarted, style: AppTextStyles.placeholderTitle,),
        ),
      ),
    );
  }
}

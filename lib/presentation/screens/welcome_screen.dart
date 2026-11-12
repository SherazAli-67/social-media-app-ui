import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app_ui/constants/number_constant.dart';
import 'package:social_media_app_ui/constants/string_const.dart';
import 'package:social_media_app_ui/core/app_colors.dart';
import 'package:social_media_app_ui/core/app_data.dart';
import 'package:social_media_app_ui/core/app_textstyles.dart';
import 'package:social_media_app_ui/core/asset_res.dart';
import 'package:social_media_app_ui/presentation/providers/welcome_provider.dart';
import 'package:social_media_app_ui/routing/router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
         /* gradient: LinearGradient(
            begin: .topCenter,
            end: .bottomCenter,
            colors: [AppColors.welcomeGradientStart, AppColors.welcomeGradientMid, AppColors.welcomeGradientEnd],
            stops: const [0, 0.58, 1],
          ),*/
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
            /*  Positioned(
                left: MediaQuery.sizeOf(context).width * NumberConstant.welcomeHeroLeftFraction,
                right: 0,
                bottom: 0,
                child: AspectRatio(
                  aspectRatio: NumberConstant.welcomeHeroAspectRatio,
                  child: DecoratedBox(
                    decoration: BoxDecoration(border: .all(color: AppColors.welcomeHeroBorder, width: NumberConstant.welcomeHeroBorderWidth)),
                    child: Image.asset(AssetRes.welcomeHero, fit: .cover,),

                  ),
                ),
              ),*/
              Padding(
                padding: .fromLTRB(NumberConstant.welcomeHorizontalPadding, 8, NumberConstant.welcomeHorizontalPadding, 0),
                child: Column(
                  spacing: NumberConstant.welcomeContentTopSpacing,
                  crossAxisAlignment: .stretch,
                  children: [
                    // _buildProgress(),
                    Padding(padding: .only(
                        left: NumberConstant.welcomeHeadlineLeft - NumberConstant.welcomeHorizontalPadding),
                      child: _buildHeadlineRow(),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: NumberConstant.welcomeCtaHorizontalInset,
                right: NumberConstant.welcomeCtaHorizontalInset,
                bottom: NumberConstant.welcomeCtaBottomInset + MediaQuery.paddingOf(context).bottom,
                child: _buildCta(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProgress() {
    return Consumer<WelcomeProvider>(
      builder: (context, provider, _) => Row(
        spacing: NumberConstant.welcomeProgressGap,
        children: List.generate(
          NumberConstant.welcomeProgressCount,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () => provider.selectProgress(index),
              child: Opacity(
                opacity: index == provider.progressIndex ? 1 : NumberConstant.welcomeInactiveProgressOpacity,
                child: Container(
                  height: NumberConstant.welcomeProgressHeight,
                  decoration: BoxDecoration(color: AppColors.welcomeProgressColor, borderRadius: .circular(NumberConstant.welcomeProgressRadius)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeadlineRow() {
    return Row(
      crossAxisAlignment: .start,
      children: [
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                //welcomeJoin, welcomeHeadline,
                //welcomeSocials, welcomeHeadlineAccent,
                //\n${StringConst.welcomeNetwork}\n${StringConst.welcomeForAmplify}\n${StringConst.welcomeInYour}\n${StringConst.welcomeLife}, welcomeHeadline
              ],
            ),
          ),
        ),
        Padding(padding: .only(top: NumberConstant.welcomeAvatarTopPadding), child: _buildAvatarBubble(),),
      ],
    );
  }

  Widget _buildAvatarBubble() {
    return DecoratedBox(
      //welcomeAvatarBg
      decoration: BoxDecoration(color: Colors.transparent, shape: .circle),
      child: Padding(
        padding: .all(NumberConstant.welcomeAvatarPadding),
        child: Row(
          mainAxisSize: .min,
          // children: [for (final avatar in AppData.welcomeAvatars) Image.asset(avatar, height: NumberConstant.welcomeAvatarImageHeight, fit: .cover,)],
        ),
      ),
    );
  }

  Widget _buildCta(BuildContext context) {
    return SizedBox();
    return GestureDetector(
      onTap: () => context.go(NamedRoutes.home.routeName),
      child: ClipRRect(
        borderRadius: .circular(NumberConstant.welcomeCtaRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: NumberConstant.welcomeCtaBlur, sigmaY: NumberConstant.welcomeCtaBlur),
          child: Container(
            decoration: BoxDecoration(color: AppColors.welcomeCtaBg, borderRadius: .circular(NumberConstant.welcomeCtaRadius)),
            padding: .symmetric(horizontal: NumberConstant.welcomeCtaHorizontalPadding, vertical: NumberConstant.welcomeCtaVerticalPadding),
            child: Row(
              children: [
                DecoratedBox(
                  //whiteColor
                  decoration: BoxDecoration(color: Colors.transparent, shape: .circle),
                  child: Padding(
                    padding: .all(NumberConstant.welcomeLockPadding),
                    //icLock
                    child: const SizedBox()
                  ),
                ),
                //letsStarted, welcomeCta, .center
                Expanded(child: const SizedBox()),
                Padding(
                  padding: .only(right: NumberConstant.welcomeCtaTrailingPadding),
                  //welcomeCtaChevrons, welcomeCtaChevron
                  child: Opacity(opacity: NumberConstant.welcomeChevronOpacity, child: const SizedBox()),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

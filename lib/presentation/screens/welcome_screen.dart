import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app_ui/constants/animation_constant.dart';
import 'package:social_media_app_ui/constants/number_constant.dart';
import 'package:social_media_app_ui/constants/string_const.dart';
import 'package:social_media_app_ui/core/app_colors.dart';
import 'package:social_media_app_ui/core/app_data.dart';
import 'package:social_media_app_ui/core/app_textstyles.dart';
import 'package:social_media_app_ui/core/asset_res.dart';
import 'package:social_media_app_ui/presentation/providers/welcome_provider.dart';
import 'package:social_media_app_ui/presentation/widgets/pressable_scale.dart';
import 'package:social_media_app_ui/routing/router.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
  late final AnimationController _enterController;
  late final Animation<double> _progressFade;
  late final Animation<Offset> _progressSlide;
  late final Animation<double> _headlineFade;
  late final Animation<Offset> _headlineSlide;
  late final Animation<double> _heroFade;
  late final Animation<Offset> _heroSlide;
  late final Animation<double> _ctaFade;
  late final Animation<Offset> _ctaSlide;

  static const _slide = Offset(0, AnimationConstant.welcomeSlideDistance / 100);

  @override
  void initState() {
    super.initState();
    _enterController = AnimationController(vsync: this, duration: AnimationConstant.welcomeEnter);
    _progressFade = _fade(0.0, 0.35);
    _progressSlide = _slideUp(0.0, 0.35);
    _headlineFade = _fade(0.15, 0.55);
    _headlineSlide = _slideUp(0.15, 0.55);
    _heroFade = _fade(0.1, 0.6);
    _heroSlide = Tween<Offset>(begin: const Offset(0.04, 0.03), end: Offset.zero).animate(
      CurvedAnimation(parent: _enterController, curve: const Interval(0.1, 0.6, curve: AnimationConstant.easeOutCubic)),
    );
    _ctaFade = _fade(0.4, 0.85);
    _ctaSlide = _slideUp(0.4, 0.85);
    _enterController.forward();
  }

  Animation<double> _fade(double begin, double end) {
    return CurvedAnimation(parent: _enterController, curve: Interval(begin, end, curve: AnimationConstant.easeOutCubic));
  }

  Animation<Offset> _slideUp(double begin, double end) {
    return Tween<Offset>(begin: _slide, end: Offset.zero).animate(
      CurvedAnimation(parent: _enterController, curve: Interval(begin, end, curve: AnimationConstant.easeOutCubic)),
    );
  }

  @override
  void dispose() {
    _enterController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: .topCenter,
            end: .bottomCenter,
            colors: [AppColors.welcomeGradientStart, AppColors.welcomeGradientMid, AppColors.welcomeGradientEnd],
            stops: const [0, 0.58, 1],
          ),
        ),
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Positioned(
                left: MediaQuery.sizeOf(context).width * NumberConstant.welcomeHeroLeftFraction,
                right: 0,
                bottom: 0,
                child: FadeTransition(
                  opacity: _heroFade,
                  child: SlideTransition(
                    position: _heroSlide,
                    child: AspectRatio(
                      aspectRatio: NumberConstant.welcomeHeroAspectRatio,
                      child: DecoratedBox(
                        decoration: BoxDecoration(border: .all(color: AppColors.welcomeHeroBorder, width: NumberConstant.welcomeHeroBorderWidth)),
                        child: Image.asset(AssetRes.welcomeHero, fit: .cover),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: .fromLTRB(NumberConstant.welcomeHorizontalPadding, 8, NumberConstant.welcomeHorizontalPadding, 0),
                child: Column(
                  spacing: NumberConstant.welcomeContentTopSpacing,
                  crossAxisAlignment: .stretch,
                  children: [
                    FadeTransition(
                      opacity: _progressFade,
                      child: SlideTransition(position: _progressSlide, child: _buildProgress()),
                    ),
                    FadeTransition(
                      opacity: _headlineFade,
                      child: SlideTransition(
                        position: _headlineSlide,
                        child: Padding(
                          padding: .only(left: NumberConstant.welcomeHeadlineLeft - NumberConstant.welcomeHorizontalPadding),
                          child: _buildHeadlineRow(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                left: NumberConstant.welcomeCtaHorizontalInset,
                right: NumberConstant.welcomeCtaHorizontalInset,
                bottom: NumberConstant.welcomeCtaBottomInset + MediaQuery.paddingOf(context).bottom,
                child: FadeTransition(
                  opacity: _ctaFade,
                  child: SlideTransition(position: _ctaSlide, child: _buildCta(context)),
                ),
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
          (index) {
            final isActive = index == provider.progressIndex;
            return Expanded(
              child: GestureDetector(
                onTap: () => provider.selectProgress(index),
                child: AnimatedOpacity(
                  opacity: isActive ? 1 : NumberConstant.welcomeInactiveProgressOpacity,
                  duration: AnimationConstant.welcomeProgress,
                  curve: AnimationConstant.easeOut,
                  child: AnimatedScale(
                    scale: isActive ? 1 : 0.96,
                    duration: AnimationConstant.welcomeProgress,
                    curve: AnimationConstant.easeOutCubic,
                    alignment: .centerLeft,
                    child: Container(
                      height: NumberConstant.welcomeProgressHeight,
                      decoration: BoxDecoration(
                        color: AppColors.welcomeProgressColor,
                        borderRadius: .circular(NumberConstant.welcomeProgressRadius),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
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
                TextSpan(text: StringConst.welcomeJoin, style: AppTextStyles.welcomeHeadline),
                TextSpan(text: StringConst.welcomeSocials, style: AppTextStyles.welcomeHeadlineAccent),
                TextSpan(
                  text: '\n${StringConst.welcomeNetwork}\n${StringConst.welcomeForAmplify}\n${StringConst.welcomeInYour}\n${StringConst.welcomeLife}',
                  style: AppTextStyles.welcomeHeadline,
                ),
              ],
            ),
          ),
        ),
        Padding(padding: .only(top: NumberConstant.welcomeAvatarTopPadding), child: _buildAvatarBubble()),
      ],
    );
  }

  Widget _buildAvatarBubble() {
    return DecoratedBox(
      decoration: BoxDecoration(color: AppColors.welcomeAvatarBg, shape: .circle),
      child: Padding(
        padding: .all(NumberConstant.welcomeAvatarPadding),
        child: Row(
          mainAxisSize: .min,
          children: [for (final avatar in AppData.welcomeAvatars) Image.asset(avatar, height: NumberConstant.welcomeAvatarImageHeight, fit: .cover)],
        ),
      ),
    );
  }

  Widget _buildCta(BuildContext context) {
    return PressableScale(
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
                  decoration: BoxDecoration(color: Colors.white, shape: .circle),
                  child: Padding(
                    padding: .all(NumberConstant.welcomeLockPadding),
                    child: SvgPicture.asset(AssetRes.icLock),
                  ),
                ),
                Expanded(child: Text(StringConst.letsStarted, style: AppTextStyles.welcomeCta, textAlign: .center)),
                Padding(
                  padding: .only(right: NumberConstant.welcomeCtaTrailingPadding),
                  child: Opacity(
                    opacity: NumberConstant.welcomeChevronOpacity,
                    child: Text(StringConst.welcomeCtaChevrons, style: AppTextStyles.welcomeCtaChevron),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

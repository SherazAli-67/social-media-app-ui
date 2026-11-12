import 'package:flutter/material.dart';
import 'package:social_media_app_ui/constants/string_const.dart';
import 'package:social_media_app_ui/core/app_colors.dart';

class AppTextStyles {
  static const welcomeHeadline = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w300,
    fontSize: 48,
    height: 62.88 / 48,
    letterSpacing: -2.2,
    color: AppColors.whiteColor,
  );

  static const welcomeHeadlineAccent = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w300,
    fontSize: 48,
    height: 62.88 / 48,
    letterSpacing: -2.2,
    color: AppColors.welcomeAccentColor,
  );

  static const welcomeCta = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w400,
    fontSize: 16,
    height: 24 / 16,
    color: AppColors.whiteColor,
  );

  static const welcomeCtaChevron = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w300,
    fontSize: 30,
    height: 30 / 30,
    letterSpacing: -8,
    color: AppColors.whiteColor,
  );

  static const appBarTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 21,
    height: 31.5 / 21,
    letterSpacing: -0.7,
    color: AppColors.blackColor,
  );

  static const storyName = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w400,
    fontSize: 12,
    height: 18 / 12,
    color: AppColors.blackColor,
  );

  static const liveBadge = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w400,
    fontSize: 10,
    height: 15 / 10,
    color: AppColors.whiteColor,
  );

  static const postAuthor = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w400,
    fontSize: 15,
    height: 22.5 / 15,
    color: AppColors.whiteColor,
  );

  static const postHandle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w300,
    fontSize: 11,
    height: 16.5 / 11,
    color: AppColors.whiteColor,
  );

  static const postStat = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w400,
    fontSize: 11,
    height: 16.5 / 11,
    color: AppColors.whiteColor,
  );

  static const postCaption = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w300,
    fontSize: 12.5,
    height: 16.875 / 12.5,
    color: AppColors.whiteColor,
  );

  static const postVerified = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w400,
    fontSize: 11,
    height: 16.5 / 11,
    color: AppColors.verifiedColor,
  );

  static const moreOptions = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w400,
    fontSize: 25,
    height: 37.5 / 25,
    color: AppColors.whiteColor,
  );

  static const profileName = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 24,
    height: 36 / 24,
    letterSpacing: -0.8,
    color: AppColors.blackColor,
  );

  static const profileBio = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w300,
    fontSize: 11.5,
    height: 14.95 / 11.5,
    color: AppColors.mutedTextColor,
  );

  static const profileStatValue = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 16,
    height: 24 / 16,
    color: AppColors.blackColor,
  );

  static const profileStatLabel = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w300,
    fontSize: 10.5,
    height: 15.75 / 10.5,
    color: AppColors.softMutedTextColor,
  );

  static const profileAction = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w400,
    fontSize: 15,
    height: 22.5 / 15,
    color: AppColors.blackColor,
  );

  static const placeholderTitle = TextStyle(
    fontFamily: StringConst.appFontFamily,
    fontWeight: .w500,
    fontSize: 18,
    color: AppColors.blackColor,
  );
}

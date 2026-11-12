import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_app_ui/constants/number_constant.dart';
import 'package:social_media_app_ui/constants/string_const.dart';
import 'package:social_media_app_ui/core/app_colors.dart';
import 'package:social_media_app_ui/core/app_data.dart';
import 'package:social_media_app_ui/core/app_textstyles.dart';
import 'package:social_media_app_ui/core/asset_res.dart';
import 'package:social_media_app_ui/core/models/post_model.dart';
import 'package:social_media_app_ui/core/models/story_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SafeArea(
        bottom: false,
        child: Column(
          spacing: NumberConstant.headerContentSpacing,
          children: [
            Padding(padding: .symmetric(horizontal: NumberConstant.headerHorizontalPadding), child: _buildHeader(),),
            Expanded(
              child: ListView(
                padding: .only(bottom: NumberConstant.feedBottomInset + MediaQuery.paddingOf(context).bottom),
                children: [
                  Padding(
                    padding: .fromLTRB(NumberConstant.storiesHorizontalPadding, NumberConstant.storiesTopPadding, NumberConstant.storiesHorizontalPadding, NumberConstant.storiesBottomPadding),
                    child: _buildStories(),
                  ),
                  Padding(
                    padding: .symmetric(horizontal: NumberConstant.horizontalPadding),
                    child: Column(
                      spacing: NumberConstant.postGap,
                      children: [for (final post in AppData.posts) _buildPost(post)],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: .spaceBetween,
      children: [
        _buildHeaderButton(icon: AssetRes.icDrawerMenu),
        Text(StringConst.brandName, style: AppTextStyles.appBarTitle,),
        Stack(
          clipBehavior: .none,
          children: [
            _buildHeaderButton(icon: AssetRes.icNotification),
            Positioned(
              top: NumberConstant.notificationDotOffset,
              right: NumberConstant.notificationDotOffset,
              child: Container(
                width: NumberConstant.notificationDotSize,
                height: NumberConstant.notificationDotSize,
                decoration: BoxDecoration(color: AppColors.notificationDotColor, shape: .circle, border: .all(color: AppColors.whiteColor)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildHeaderButton({required String icon}) {
    return DecoratedBox(
      decoration: BoxDecoration(color: AppColors.surfaceColor, shape: .circle),
      child: Padding(
        padding: .all(NumberConstant.headerButtonPadding),
        child: SvgPicture.asset(icon, colorFilter: .mode(AppColors.blackColor, .srcIn),),
      ),
    );
  }

  Widget _buildStories() {
    return SingleChildScrollView(
      scrollDirection: .horizontal,
      child: Row(
        spacing: NumberConstant.storyGap,
        crossAxisAlignment: .start,
        children: [for (final story in AppData.stories) _buildStory(story)],
      ),
    );
  }

  Widget _buildStory(StoryModel story) {
    return Column(
      spacing: NumberConstant.storyNameTopGap,
      children: [
        Stack(
          alignment: .center,
          clipBehavior: .none,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(shape: .circle, border: .all(color: AppColors.storyRingColor, width: NumberConstant.storyBorderWidth)),
              child: Padding(
                padding: .all(NumberConstant.storyAvatarPadding),
                child: ClipOval(child: Image.asset(story.image, width: NumberConstant.storyImageSize, height: NumberConstant.storyImageSize, fit: .cover,)),
              ),
            ),
            if (story.isLive)
              Positioned(
                bottom: 0,
                child: DecoratedBox(
                  decoration: BoxDecoration(color: AppColors.blackColor, borderRadius: .circular(NumberConstant.liveBadgeRadius)),
                  child: Padding(
                    padding: .symmetric(horizontal: NumberConstant.liveBadgeHorizontalPadding, vertical: NumberConstant.liveBadgeVerticalPadding),
                    child: Text(StringConst.live, style: AppTextStyles.liveBadge,),
                  ),
                ),
              ),
          ],
        ),
        Text(story.name, style: AppTextStyles.storyName,),
      ],
    );
  }

  Widget _buildPost(PostModel post) {
    return ClipRRect(
      borderRadius: .circular(NumberConstant.postRadius),
      child: AspectRatio(
        aspectRatio: post.aspectRatio,
        child: Stack(
          fit: .expand,
          children: [
            Image.asset(post.image, fit: .cover,),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: .topCenter,
                  end: .bottomCenter,
                  colors: [AppColors.postOverlayStart, AppColors.postOverlayMid, AppColors.postOverlayMid, AppColors.postOverlayMid, AppColors.postOverlayEnd],
                  stops: const [0, 0.28, 0.28, 0.55, 1],
                ),
              ),
            ),
            Positioned(
              top: NumberConstant.postOverlayPadding,
              left: NumberConstant.postOverlayPadding,
              right: NumberConstant.postOverlayPadding,
              child: Row(
                spacing: NumberConstant.postCreatorGap,
                children: [
                  Expanded(child: _buildCreatorOverlay(post)),
                  _buildMoreButton(),
                ],
              ),
            ),
            if (post.caption.isNotEmpty)
              Positioned(
                left: NumberConstant.postBottomPadding,
                right: NumberConstant.postBottomPadding,
                bottom: NumberConstant.postBottomPadding,
                child: Column(
                  spacing: NumberConstant.postCaptionTopGap,
                  crossAxisAlignment: .start,
                  children: [
                    Row(
                      spacing: NumberConstant.postStatsGap,
                      children: [
                        _buildStat(icon: AssetRes.icFavorite, value: '${post.likes}'),
                        _buildStat(icon: AssetRes.icComment, value: '${post.comments}'),
                        _buildStat(icon: AssetRes.icShare, value: '${post.shares}'),
                      ],
                    ),
                    Text(post.caption, style: AppTextStyles.postCaption,),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildCreatorOverlay(PostModel post) {
    return Row(
      spacing: NumberConstant.postCreatorGap,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(shape: .circle, border: .all(color: AppColors.postAvatarBorder, width: NumberConstant.postAvatarBorderWidth)),
          child: ClipOval(child: Image.asset(post.avatar, width: NumberConstant.postAvatarSize, height: NumberConstant.postAvatarSize, fit: .cover,)),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              Row(
                spacing: 4,
                children: [
                  Flexible(child: Text(post.author, style: AppTextStyles.postAuthor, overflow: .ellipsis,)),
                  if (post.isVerified) Text(StringConst.verifiedMark, style: AppTextStyles.postVerified,),
                ],
              ),
              Text(post.handle, style: AppTextStyles.postHandle,),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMoreButton() {
    return ClipOval(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: NumberConstant.postMoreBlur, sigmaY: NumberConstant.postMoreBlur),
        child: DecoratedBox(
          decoration: BoxDecoration(color: AppColors.moreButtonBg, shape: .circle),
          child: Padding(
            padding: .all(NumberConstant.postMorePadding),
            child: Text(StringConst.moreOptions, style: AppTextStyles.moreOptions,),
          ),
        ),
      ),
    );
  }

  Widget _buildStat({required String icon, required String value}) {
    return Row(
      spacing: NumberConstant.postStatIconGap,
      mainAxisSize: .min,
      children: [
        SvgPicture.asset(icon, width: NumberConstant.postStatIconSize, height: NumberConstant.postStatIconSize, colorFilter: .mode(AppColors.whiteColor, .srcIn),),
        Text(value, style: AppTextStyles.postStat,),
      ],
    );
  }
}

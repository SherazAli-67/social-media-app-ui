import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:social_media_app_ui/constants/number_constant.dart';
import 'package:social_media_app_ui/constants/string_const.dart';
import 'package:social_media_app_ui/core/app_colors.dart';
import 'package:social_media_app_ui/core/app_data.dart';
import 'package:social_media_app_ui/core/app_textstyles.dart';
import 'package:social_media_app_ui/core/asset_res.dart';
import 'package:social_media_app_ui/core/models/profile_grid_item_model.dart';
import 'package:social_media_app_ui/presentation/providers/profile_tab_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _tabIcons = [AssetRes.icDrawerMenu, AssetRes.icVideos, AssetRes.icFavorite, AssetRes.icBookmark];

  @override
  Widget build(BuildContext context) {
    final profile = AppData.profile;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: SingleChildScrollView(
        padding: .only(bottom: NumberConstant.feedBottomInset + MediaQuery.paddingOf(context).bottom),
        child: Column(
          children: [
            _buildCoverHeader(profile.cover, profile.avatar),
            Padding(
              padding: .symmetric(horizontal: NumberConstant.horizontalPadding),
              child: Column(
                children: [
                  Padding(padding: .only(top: NumberConstant.profileNameTopPadding), child: Text(profile.name, style: AppTextStyles.profileName, textAlign: .center,),),
                  Padding(padding: .only(top: NumberConstant.profileBioTopPadding), child: Text(profile.bio, style: AppTextStyles.profileBio, textAlign: .center,),),
                  Padding(padding: .only(top: NumberConstant.profileStatsTopGap), child: _buildStats(profile.followers, profile.followings, profile.posts),),
                  Padding(padding: .only(top: NumberConstant.profileActionsTopPadding), child: _buildActions(),),
                  Padding(padding: .only(top: NumberConstant.profileTabsTopPadding), child: _buildTabs(),),
                  Padding(padding: .only(top: NumberConstant.profileGridTopPadding), child: _buildGrid(),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverHeader(String cover, String avatar) {
    return Stack(
      alignment: .bottomCenter,
      clipBehavior: .none,
      children: [
        Padding(
          padding: .only(bottom: NumberConstant.profileContentTopOverlap),
          child: ClipRRect(
            borderRadius: .vertical(bottom: .circular(NumberConstant.coverBottomRadius)),
            child: AspectRatio(
              aspectRatio: NumberConstant.coverAspectRatio,
              child: Stack(
                fit: .expand,
                children: [
                  Image.asset(cover, fit: .cover,),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: .topCenter,
                        end: .bottomCenter,
                        colors: [AppColors.coverOverlayTop, AppColors.postOverlayMid, AppColors.postOverlayMid, AppColors.coverOverlayBottom],
                        stops: const [0, 0.55, 0.55, 1],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          width: NumberConstant.profileAvatarSize,
          height: NumberConstant.profileAvatarSize,
          decoration: BoxDecoration(shape: .circle, border: .all(color: AppColors.whiteColor, width: NumberConstant.profileAvatarBorderWidth), color: AppColors.whiteColor),
          clipBehavior: .antiAlias,
          child: Image.asset(avatar, fit: .cover,),
        ),
      ],
    );
  }

  Widget _buildStats(String followers, String followings, String posts) {
    return Padding(
      padding: .symmetric(horizontal: NumberConstant.profileStatsHorizontalPadding),
      child: Row(
        children: [
          Expanded(child: _buildStat(value: followers, label: StringConst.followers)),
          Container(width: NumberConstant.profileDividerWidth, height: NumberConstant.profileDividerHeight, color: AppColors.dividerColor),
          Expanded(child: _buildStat(value: followings, label: StringConst.followings)),
          Container(width: NumberConstant.profileDividerWidth, height: NumberConstant.profileDividerHeight, color: AppColors.dividerColor),
          Expanded(child: _buildStat(value: posts, label: StringConst.posts)),
        ],
      ),
    );
  }

  Widget _buildStat({required String value, required String label}) {
    return Column(
      spacing: NumberConstant.profileStatLabelTopGap,
      children: [
        Text(value, style: AppTextStyles.profileStatValue, textAlign: .center,),
        Text(label, style: AppTextStyles.profileStatLabel, textAlign: .center,),
      ],
    );
  }

  Widget _buildActions() {
    return Row(
      spacing: NumberConstant.profileActionGap,
      children: [
        Expanded(child: _buildActionButton(StringConst.follow)),
        Expanded(child: _buildActionButton(StringConst.message)),
        Expanded(child: _buildActionButton(StringConst.insight)),
      ],
    );
  }

  Widget _buildActionButton(String label) {
    return DecoratedBox(
      decoration: BoxDecoration(color: AppColors.surfaceColor, borderRadius: .circular(NumberConstant.profileActionRadius)),
      child: Padding(
        padding: .symmetric(vertical: NumberConstant.profileActionVerticalPadding),
        child: Text(label, style: AppTextStyles.profileAction, textAlign: .center,),
      ),
    );
  }

  Widget _buildTabs() {
    return Consumer<ProfileTabProvider>(
      builder: (context, provider, _) => DecoratedBox(
        decoration: BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.tabBorderColor))),
        child: Row(
          children: [
            for (var i = 0; i < _tabIcons.length; i++)
              Expanded(
                child: GestureDetector(
                  onTap: () => provider.selectTab(i),
                  behavior: .opaque,
                  child: Column(
                    children: [
                      Padding(
                        padding: .symmetric(vertical: NumberConstant.profileTabVerticalPadding),
                        child: SvgPicture.asset(_tabIcons[i], colorFilter: .mode(AppColors.blackColor, .srcIn),),
                      ),
                      Align(
                        child: FractionallySizedBox(
                          widthFactor: NumberConstant.profileTabUnderlineWidthFactor,
                          child: Container(
                            height: NumberConstant.profileTabUnderlineHeight,
                            color: i == provider.selectedTabIndex ? AppColors.blackColor : AppColors.postOverlayMid,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid() {
    return Consumer<ProfileTabProvider>(
      builder: (context, provider, _) {
        if (provider.selectedTabIndex != 0) return const SizedBox.shrink();
        return Row(
          spacing: NumberConstant.profileGridGap,
          crossAxisAlignment: .start,
          children: [
            Expanded(
              child: Column(
                spacing: NumberConstant.profileGridGap,
                children: [_buildGridItem(AppData.profileGridItems[0]), _buildGridItem(AppData.profileGridItems[3])],
              ),
            ),
            Expanded(
              child: Column(
                spacing: NumberConstant.profileGridGap,
                children: [_buildGridItem(AppData.profileGridItems[1]), _buildGridItem(AppData.profileGridItems[2])],
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildGridItem(ProfileGridItemModel item) {
    return ClipRRect(
      borderRadius: .circular(NumberConstant.profileGridRadius),
      child: AspectRatio(aspectRatio: item.aspectRatio, child: Image.asset(item.image, fit: .cover,),),
    );
  }
}

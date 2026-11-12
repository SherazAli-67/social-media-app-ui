import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:social_media_app_ui/constants/animation_constant.dart';
import 'package:social_media_app_ui/constants/number_constant.dart';
import 'package:social_media_app_ui/constants/string_const.dart';
import 'package:social_media_app_ui/core/app_colors.dart';
import 'package:social_media_app_ui/core/app_data.dart';
import 'package:social_media_app_ui/core/app_textstyles.dart';
import 'package:social_media_app_ui/core/asset_res.dart';
import 'package:social_media_app_ui/core/models/post_model.dart';
import 'package:social_media_app_ui/core/models/story_model.dart';
import 'package:social_media_app_ui/presentation/widgets/pressable_scale.dart';
import 'package:social_media_app_ui/presentation/widgets/pulse_opacity.dart';
import 'package:social_media_app_ui/presentation/widgets/staggered_fade_slide.dart';

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
            Padding(padding: .symmetric(horizontal: NumberConstant.headerHorizontalPadding), child: _buildHeader()),
            Expanded(
              child: ListView(
                padding: .only(bottom: NumberConstant.feedBottomInset + MediaQuery.paddingOf(context).bottom),
                children: [
                  Padding(
                    padding: .fromLTRB(
                      NumberConstant.storiesHorizontalPadding,
                      NumberConstant.storiesTopPadding,
                      NumberConstant.storiesHorizontalPadding,
                      NumberConstant.storiesBottomPadding,
                    ),
                    child: _buildStories(),
                  ),
                  Padding(
                    padding: .symmetric(horizontal: NumberConstant.horizontalPadding),
                    child: Column(
                      spacing: NumberConstant.postGap,
                      children: [
                        for (var i = 0; i < AppData.posts.length; i++)
                          StaggeredFadeSlide(index: i, child: _PostCard(post: AppData.posts[i])),
                      ],
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
        Text(StringConst.brandName, style: AppTextStyles.appBarTitle),
        Stack(
          clipBehavior: .none,
          children: [
            _buildHeaderButton(icon: AssetRes.icNotification),
            Positioned(
              top: NumberConstant.notificationDotOffset,
              right: NumberConstant.notificationDotOffset,
              child: PulseOpacity(
                child: Container(
                  width: NumberConstant.notificationDotSize,
                  height: NumberConstant.notificationDotSize,
                  decoration: BoxDecoration(
                    color: AppColors.notificationDotColor,
                    shape: .circle,
                    border: .all(color: AppColors.whiteColor),
                  ),
                ),
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
        child: SvgPicture.asset(icon, colorFilter: .mode(AppColors.blackColor, .srcIn)),
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
    return PressableScale(
      scale: AnimationConstant.storyPressScale,
      onTap: () {},
      child: Column(
        spacing: NumberConstant.storyNameTopGap,
        children: [
          Stack(
            alignment: .center,
            clipBehavior: .none,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: .circle,
                  border: .all(color: AppColors.storyRingColor, width: NumberConstant.storyBorderWidth),
                ),
                child: Padding(
                  padding: .all(NumberConstant.storyAvatarPadding),
                  child: ClipOval(
                    child: Image.asset(story.image, width: NumberConstant.storyImageSize, fit: .cover),
                  ),
                ),
              ),
              if (story.isLive)
                Positioned(
                  bottom: 0,
                  child: PulseOpacity(
                    minOpacity: AnimationConstant.livePulseMinOpacity,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: AppColors.blackColor,
                        borderRadius: .circular(NumberConstant.liveBadgeRadius),
                      ),
                      child: Padding(
                        padding: .symmetric(
                          horizontal: NumberConstant.liveBadgeHorizontalPadding,
                          vertical: NumberConstant.liveBadgeVerticalPadding,
                        ),
                        child: Text(StringConst.live, style: AppTextStyles.liveBadge),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PostCard extends StatefulWidget {
  final PostModel post;

  const _PostCard({required this.post});

  @override
  State<_PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<_PostCard> with SingleTickerProviderStateMixin {
  late int _likes = widget.post.likes;
  var _liked = false;
  var _statScale = 1.0;
  Timer? _bounceTimer;
  late final AnimationController _heartController;
  late final Animation<double> _heartOpacity;
  late final Animation<double> _heartScale;

  @override
  void initState() {
    super.initState();
    _heartController = AnimationController(vsync: this, duration: AnimationConstant.doubleTapHeart);
    _heartOpacity = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0, end: 1), weight: 20),
      TweenSequenceItem(tween: ConstantTween(1), weight: 45),
      TweenSequenceItem(tween: Tween(begin: 1, end: 0), weight: 35),
    ]).animate(CurvedAnimation(parent: _heartController, curve: AnimationConstant.easeOut));
    _heartScale = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.6, end: AnimationConstant.doubleTapHeartScale), weight: 35),
      TweenSequenceItem(tween: Tween(begin: AnimationConstant.doubleTapHeartScale, end: 1), weight: 25),
      TweenSequenceItem(tween: ConstantTween(1), weight: 40),
    ]).animate(CurvedAnimation(parent: _heartController, curve: AnimationConstant.easeOutCubic));
  }

  @override
  void dispose() {
    _bounceTimer?.cancel();
    _heartController.dispose();
    super.dispose();
  }

  void _bounceStat() {
    setState(() => _statScale = AnimationConstant.likeBounceScale);
    _bounceTimer?.cancel();
    _bounceTimer = Timer(AnimationConstant.likeBounce, () {
      if (mounted) setState(() => _statScale = 1);
    });
  }

  void _likeFromDoubleTap() {
    if (!_liked) {
      setState(() {
        _liked = true;
        _likes += 1;
      });
    }
    _bounceStat();
    _heartController
      ..reset()
      ..forward();
  }

  void _toggleLikeFromStat() {
    setState(() {
      _liked = !_liked;
      _likes += _liked ? 1 : -1;
    });
    _bounceStat();
  }

  @override
  Widget build(BuildContext context) {
    final post = widget.post;
    return GestureDetector(
      onDoubleTap: _likeFromDoubleTap,
      child: ClipRRect(
        borderRadius: .circular(NumberConstant.postRadius),
        child: AspectRatio(
          aspectRatio: post.aspectRatio,
          child: Stack(
            fit: .expand,
            children: [
              Image.asset(post.image, fit: .cover),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: .topCenter,
                    end: .bottomCenter,
                    colors: [
                      AppColors.postOverlayStart,
                      AppColors.postOverlayMid,
                      AppColors.postOverlayMid,
                      AppColors.postOverlayMid,
                      AppColors.postOverlayEnd,
                    ],
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
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: _toggleLikeFromStat,
                            child: AnimatedScale(
                              scale: _statScale,
                              duration: AnimationConstant.likeBounce,
                              curve: AnimationConstant.easeOut,
                              child: Row(
                                spacing: NumberConstant.postStatIconGap,
                                mainAxisSize: .min,
                                children: [
                                  SvgPicture.asset(
                                    AssetRes.icFavorite,
                                    width: NumberConstant.postStatIconSize,
                                    height: NumberConstant.postStatIconSize,
                                    colorFilter: .mode(
                                      _liked ? AppColors.notificationDotColor : AppColors.whiteColor,
                                      .srcIn,
                                    ),
                                  ),
                                  Text('$_likes', style: AppTextStyles.postStat),
                                ],
                              ),
                            ),
                          ),
                          _buildStat(icon: AssetRes.icComment, value: '${post.comments}'),
                          _buildStat(icon: AssetRes.icShare, value: '${post.shares}'),
                        ],
                      ),
                      Text(post.caption, style: AppTextStyles.postCaption),
                    ],
                  ),
                ),
              IgnorePointer(
                child: FadeTransition(
                  opacity: _heartOpacity,
                  child: ScaleTransition(
                    scale: _heartScale,
                    child: Center(
                      child: Icon(
                        Icons.favorite,
                        size: 84,
                        color: AppColors.whiteColor.withValues(alpha: 0.92),
                        shadows: const [Shadow(color: Color(0x66000000), blurRadius: 16)],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCreatorOverlay(PostModel post) {
    return Row(
      spacing: NumberConstant.postCreatorGap,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
            shape: .circle,
            border: .all(color: AppColors.postAvatarBorder, width: NumberConstant.postAvatarBorderWidth),
          ),
          child: ClipOval(
            child: Image.asset(
              post.avatar,
              width: NumberConstant.postAvatarSize,
              height: NumberConstant.postAvatarSize,
              fit: .cover,
            ),
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: .start,
            mainAxisSize: .min,
            children: [
              Row(
                spacing: 4,
                children: [
                  Flexible(child: Text(post.author, style: AppTextStyles.postAuthor)),
                  if (post.isVerified) Text(StringConst.verifiedMark, style: AppTextStyles.postVerified),
                ],
              ),
              Text(post.handle, style: AppTextStyles.postHandle),
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
            child: Text(StringConst.moreOptions, style: AppTextStyles.moreOptions),
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
        SvgPicture.asset(
          icon,
          width: NumberConstant.postStatIconSize,
          height: NumberConstant.postStatIconSize,
          colorFilter: .mode(AppColors.whiteColor, .srcIn),
        ),
        Text(value, style: AppTextStyles.postStat),
      ],
    );
  }
}

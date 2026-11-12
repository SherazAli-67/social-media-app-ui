import 'package:flutter/animation.dart';

class AnimationConstant {
  static const shortFeedback = Duration(milliseconds: 180);
  static const contentEnter = Duration(milliseconds: 280);
  static const welcomeEnter = Duration(milliseconds: 700);
  static const welcomeProgress = Duration(milliseconds: 220);
  static const pulse = Duration(milliseconds: 900);
  static const staggerDelay = Duration(milliseconds: 70);
  static const likeBounce = Duration(milliseconds: 160);
  static const pressScale = 0.96;
  static const storyPressScale = 0.92;
  static const likeBounceScale = 1.22;
  static const welcomeSlideDistance = 18.0;
  static const feedSlideDistance = 0.05;
  static const pulseMinOpacity = 0.35;
  static const livePulseMinOpacity = 0.55;
  static const staggerMaxIndex = 5;

  static const easeOut = Curves.easeOut;
  static const easeOutCubic = Curves.easeOutCubic;
  static const easeInOut = Curves.easeInOut;
}

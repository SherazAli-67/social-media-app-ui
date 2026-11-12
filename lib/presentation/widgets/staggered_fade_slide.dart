import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social_media_app_ui/constants/animation_constant.dart';

class StaggeredFadeSlide extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration delayPerItem;
  final Duration duration;
  final double slideDistance;

  const StaggeredFadeSlide({
    super.key,
    required this.child,
    required this.index,
    this.delayPerItem = AnimationConstant.staggerDelay,
    this.duration = AnimationConstant.contentEnter,
    this.slideDistance = AnimationConstant.feedSlideDistance,
  });

  @override
  State<StaggeredFadeSlide> createState() => _StaggeredFadeSlideState();
}

class _StaggeredFadeSlideState extends State<StaggeredFadeSlide> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  Timer? _delayTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    final curve = CurvedAnimation(parent: _controller, curve: AnimationConstant.easeOutCubic);
    _opacity = curve;
    _slide = Tween<Offset>(begin: Offset(0, widget.slideDistance), end: Offset.zero).animate(curve);

    final cappedIndex = min(widget.index, AnimationConstant.staggerMaxIndex);
    _delayTimer = Timer(widget.delayPerItem * cappedIndex, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _slide, child: widget.child),
    );
  }
}

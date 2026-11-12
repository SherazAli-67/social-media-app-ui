import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:social_media_app_ui/constants/animation_constant.dart';
import 'package:social_media_app_ui/presentation/widgets/shell_enter_scope.dart';

class StaggeredFadeSlide extends StatefulWidget {
  final Widget child;
  final int index;
  final Duration delayPerItem;
  final Duration duration;
  final Offset beginOffset;
  final bool waitForRoute;

  const StaggeredFadeSlide({
    super.key,
    required this.child,
    required this.index,
    this.delayPerItem = AnimationConstant.staggerDelay,
    this.duration = AnimationConstant.contentEnter,
    this.beginOffset = AnimationConstant.feedBeginOffset,
    this.waitForRoute = true,
  });

  @override
  State<StaggeredFadeSlide> createState() => _StaggeredFadeSlideState();
}

class _StaggeredFadeSlideState extends State<StaggeredFadeSlide> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _slide;
  Timer? _delayTimer;
  Animation<double>? _routeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    final curve = CurvedAnimation(parent: _controller, curve: AnimationConstant.easeOutCubic);
    _opacity = curve;
    _slide = Tween<Offset>(begin: widget.beginOffset, end: Offset.zero).animate(curve);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!widget.waitForRoute) {
      _startAfterIndexDelay();
      return;
    }

    final shellEnter = ShellEnterScope.maybeOf(context);
    if (shellEnter != null) {
      if (shellEnter.ready) {
        _startAfterIndexDelay();
      }
      return;
    }

    final animation = ModalRoute.of(context)?.animation;
    if (animation != null && animation.value < 1.0) {
      _listenToRoute(animation);
      return;
    }
    _startAfterIndexDelay();
  }

  void _listenToRoute(Animation<double> animation) {
    if (identical(_routeAnimation, animation)) return;
    _routeAnimation?.removeStatusListener(_onRouteStatus);
    _routeAnimation = animation;
    if (animation.status == AnimationStatus.completed || animation.value >= 1.0) {
      _startAfterIndexDelay();
      return;
    }
    animation.addStatusListener(_onRouteStatus);
  }

  void _onRouteStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _routeAnimation?.removeStatusListener(_onRouteStatus);
    _delayTimer?.cancel();
    _delayTimer = Timer(AnimationConstant.routeSettle, _startAfterIndexDelay);
  }

  void _startAfterIndexDelay() {
    if (!mounted || _controller.isAnimating || _controller.isCompleted) return;
    final cappedIndex = min(widget.index, AnimationConstant.staggerMaxIndex);
    _delayTimer?.cancel();
    _delayTimer = Timer(widget.delayPerItem * cappedIndex, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _delayTimer?.cancel();
    _routeAnimation?.removeStatusListener(_onRouteStatus);
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

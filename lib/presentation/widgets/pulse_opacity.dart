import 'package:flutter/material.dart';
import 'package:social_media_app_ui/constants/animation_constant.dart';

class PulseOpacity extends StatefulWidget {
  final Widget child;
  final double minOpacity;
  final Duration duration;

  const PulseOpacity({
    super.key,
    required this.child,
    this.minOpacity = AnimationConstant.pulseMinOpacity,
    this.duration = AnimationConstant.pulse,
  });

  @override
  State<PulseOpacity> createState() => _PulseOpacityState();
}

class _PulseOpacityState extends State<PulseOpacity> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration)..repeat(reverse: true);
    _opacity = Tween<double>(begin: widget.minOpacity, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: AnimationConstant.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(opacity: _opacity, child: widget.child);
  }
}

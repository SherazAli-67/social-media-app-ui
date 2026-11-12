import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:social_media_app_ui/constants/animation_constant.dart';
import 'package:social_media_app_ui/constants/number_constant.dart';
import 'package:social_media_app_ui/presentation/widgets/app_bottom_nav_bar.dart';
import 'package:social_media_app_ui/presentation/widgets/shell_enter_scope.dart';

class MainShell extends StatefulWidget {
  final StatefulNavigationShell navigationShell;

  const MainShell({super.key, required this.navigationShell});

  @override
  State<MainShell> createState() => _MainShellState();
}

class _MainShellState extends State<MainShell> {
  var _enterReady = false;
  var _armed = false;
  Animation<double>? _routeAnimation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_armed || _enterReady) return;
    _armed = true;

    final animation = ModalRoute.of(context)?.animation;
    if (animation != null && animation.value < 1.0) {
      _routeAnimation = animation;
      animation.addStatusListener(_onRouteStatus);
      return;
    }

    // Cold start / already settled.
    _enterReady = true;
  }

  void _onRouteStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;
    _routeAnimation?.removeStatusListener(_onRouteStatus);
    Future<void>.delayed(AnimationConstant.routeSettle, () {
      if (!mounted || _enterReady) return;
      setState(() => _enterReady = true);
    });
  }

  @override
  void dispose() {
    _routeAnimation?.removeStatusListener(_onRouteStatus);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ShellEnterScope(
      ready: _enterReady,
      child: Scaffold(
        body: Stack(
          children: [
            widget.navigationShell,
            Positioned(
              left: NumberConstant.bottomNavHorizontalInset,
              right: NumberConstant.bottomNavHorizontalInset,
              bottom: NumberConstant.bottomNavBottomInset + MediaQuery.paddingOf(context).bottom,
              child: AppBottomNavBar(
                selectedIndex: widget.navigationShell.currentIndex,
                onSelected: (index) => widget.navigationShell.goBranch(
                  index,
                  initialLocation: index == widget.navigationShell.currentIndex,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

/// Notifies subtree when the shell route page transition has finished.
///
/// Branch screens (e.g. Home) live under a nested navigator, so their nearest
/// [ModalRoute] is often already completed while the shell page is still
/// entering after welcome → home.
class ShellEnterScope extends InheritedWidget {
  final bool ready;

  const ShellEnterScope({
    super.key,
    required this.ready,
    required super.child,
  });

  static ShellEnterScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ShellEnterScope>();
  }

  @override
  bool updateShouldNotify(ShellEnterScope oldWidget) => ready != oldWidget.ready;
}

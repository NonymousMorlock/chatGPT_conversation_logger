import 'package:conversation_log/core/utils/constants.dart';
import 'package:conversation_log/src/home/presentation/views/home_screen.dart';
import 'package:flutter/material.dart' hide MenuBar;
import 'package:menu_bar/menu_bar.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomeScreen.routeName:
      return _pageBuilder(const HomeScreen(), settings: settings);
    default:
      return _pageBuilder(const Placeholder(), settings: settings);
  }
}

PageRouteBuilder<dynamic> _pageBuilder(
  Widget page, {
  required RouteSettings settings,
}) {
  return PageRouteBuilder<dynamic>(
    settings: settings,
    pageBuilder: (_, __, ___) => page,
    transitionsBuilder: (_, a, __, child) {
      return FadeTransition(
        opacity: a,
        child: MenuBar(
          barButtons: kMenuButtons,
          child: child,
        ),
      );
    },
  );
}

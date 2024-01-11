import 'package:conversation_log/core/common/features/search/presentation/views/search_view.dart';
import 'package:conversation_log/core/common/theme/theme.dart';
import 'package:conversation_log/core/utils/constants.dart';
import 'package:conversation_log/src/home/presentation/views/home_screen.dart';
import 'package:flutter/material.dart' hide MenuBar;
import 'package:flutter_bloc/flutter_bloc.dart';
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
    transitionsBuilder: (context, a, __, child) {
      return FadeTransition(
        opacity: a,
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (context, state) {
            debugPrint(state.primaryTextColor.toString());
            return Material(
              child: MenuBarWidget(
                barButtonStyle: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(
                    state.primaryTextColor,
                  ),
                ),
                barStyle: MenuStyle(
                  backgroundColor:
                      MaterialStatePropertyAll(state.backgroundColor),
                ),
                barButtons: kMenuButtons,
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    const SearchView(),
                    const SizedBox(height: 10),
                    Expanded(child: child),
                  ],
                ),
              ),
            );
          },
        ),
      );
    },
  );
}

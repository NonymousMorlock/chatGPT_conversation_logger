import 'package:bloc/bloc.dart';
import 'package:conversation_log/core/common/res/res.dart';
import 'package:conversation_log/core/common/settings/application/setting_repository.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  factory ThemeCubit({required Future<bool> isDarkMode}) {
    _instance ??= ThemeCubit._(isDarkMode: isDarkMode);
    return _instance!;
  }

  ThemeCubit._({required Future<bool> isDarkMode}) : super(const DarkTheme()) {
    initialize(isDarkMode);
  }
  static ThemeCubit? _instance;

  Future<void> initialize(Future<bool> isDarkMode) async {
    await isDarkMode.then(
      (data) {
        emit(
          data ? const DarkTheme() : const LightTheme(),
        );
      },
    );
  }

  Future<void> getThemeDark() async {
    await SettingRepository().setDarkModeSetting(value: true);
    emit(const DarkTheme());
  }

  Future<void> getThemeLight() async {
    await SettingRepository().setDarkModeSetting(value: false);
    emit(const LightTheme());
  }
}

import 'package:bloc/bloc.dart';
import 'package:conversation_log/core/common/settings/application/setting_repository.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required this.isDarkMode}) : super(const ThemeStateDark());

  final Future<bool> isDarkMode;

  Future<void> initialize() async {
    await isDarkMode.then(
      (data) {
        emit(
          data ? const ThemeStateDark() : const ThemeStateLight(),
        );
      },
    );
  }

  Future<void> getThemeDark() async {
    await SettingRepository().setDarkModeSetting(value: true);
    emit(const ThemeStateDark());
  }

  Future<void> getThemeLight() async {
    await SettingRepository().setDarkModeSetting(value: false);
    emit(const ThemeStateLight());
  }
}

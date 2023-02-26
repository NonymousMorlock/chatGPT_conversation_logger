import 'package:conversation_log/core/common/settings/domain/i_setting_repository.dart';
import 'package:conversation_log/core/common/theme/theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'setting_state.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit({
    required this.settingRep,
    required this.themeCubit,
  }) : super(SettingState.initial());
  final ISettingRepository settingRep;
  final ThemeCubit themeCubit;

  Future<void> initialize() async {
    final setting = await settingRep.getSetting();
    final newSettingState = state.copyWith(
      isDarkMode: setting.isDarkMode,
    );
    emit(newSettingState);
  }

  Future<void> toggleDarkModeOption({required bool val}) async {
    final newState = state.copyWith(isDarkMode: val);
    await settingRep.setDarkModeSetting(value: val);

    if (newState.isDarkMode) {
      await themeCubit.getThemeDark();
    } else {
      await themeCubit.getThemeLight();
    }

    emit(newState);
  }
}

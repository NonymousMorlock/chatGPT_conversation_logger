part of 'setting_cubit.dart';

@immutable
class SettingState extends Equatable {
  const SettingState({
    required this.isDarkMode,
  });

  factory SettingState.initial() => const SettingState(
        isDarkMode: false,
      );

  final bool isDarkMode;

  SettingState copyWith({
    bool? isDarkMode,
  }) =>
      SettingState(
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );

  @override
  List<Object?> get props => [
        isDarkMode,
      ];
}

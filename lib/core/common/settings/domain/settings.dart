import 'dart:convert';

import 'package:equatable/equatable.dart';

class Settings extends Equatable {
  const Settings({
    required this.isDarkMode,
  });

  factory Settings.fromJson(String source) => Settings.fromMap(
        jsonDecode(source) as Map<String, dynamic>,
      );

  factory Settings.fromMap(Map<String, dynamic> json) => Settings(
        isDarkMode: json[darkMode] as bool? ?? false,
      );

  static const String darkMode = 'darkMode';
  static const String setting = 'setting';

  final bool isDarkMode;

  Map<String, dynamic> toMap() => {
        darkMode: isDarkMode,
      };

  String toJson() => jsonEncode(toMap());

  Settings copyWith({
    bool? isSoundOn,
    bool? isMusicOn,
    bool? isDarkMode,
    bool? isMute,
  }) {
    return Settings(
      isDarkMode: isDarkMode ?? this.isDarkMode,
    );
  }

  @override
  List<Object?> get props => [
        isDarkMode,
      ];
}

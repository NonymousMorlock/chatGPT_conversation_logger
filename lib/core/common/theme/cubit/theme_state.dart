part of 'theme_cubit.dart';

abstract class ThemeState {
  Color get backgroundColor;
  Color get primaryTextColor;
  Color get appBarColor;
  Color get accentColor;
  Color get sideRailColour;
  Color get inactiveButtonColour;
  Color get selectedItemColour;
  MaterialColor get primarySwatch;
  String get loadingFiles;
}

class DarkTheme implements ThemeState {
  const DarkTheme();
  @override
  Color get backgroundColor => const Color(0xFF202123);

  @override
  Color get sideRailColour => const Color(0xFF343541);

  @override
  Color get inactiveButtonColour => const Color(0xFF343541);

  @override
  Color get selectedItemColour => const Color(0xFF202123);

  @override
  Color get primaryTextColor => const Color(0xFFEEEEEE);

  @override
  Color get appBarColor => const Color(0xFF13B9FF);

  @override
  Color get accentColor => const Color(0xFF13B9FF);

  @override
  MaterialColor get primarySwatch => Colors.blue;

  @override
  String get loadingFiles => Res.loadingFilesDark;
}

class LightTheme implements ThemeState {
  const LightTheme();
  @override
  Color get backgroundColor => const Color(0xFFFFFFFF);

  @override
  Color get sideRailColour => const Color(0xFF13B9FF);

  @override
  Color get primaryTextColor => const Color(0xFF000000);

  @override
  Color get appBarColor => const Color(0xFF13B9FF);

  @override
  Color get accentColor => const Color(0xFF13B9FF);

  @override
  MaterialColor get primarySwatch => Colors.grey;

  @override
  Color get inactiveButtonColour => const Color(0xFF9E9E9E);

  @override
  Color get selectedItemColour => const Color(0xFF0D47A1);

  @override
  String get loadingFiles => Res.loadingFilesLight;
}

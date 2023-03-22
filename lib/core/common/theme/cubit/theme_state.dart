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
}

class ThemeStateDark implements ThemeState {
  const ThemeStateDark();
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
}

class ThemeStateLight implements ThemeState {
  const ThemeStateLight();
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
}

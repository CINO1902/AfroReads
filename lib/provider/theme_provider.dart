import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum ThemeModeType { light, dark, system }

class ThemeProvider with ChangeNotifier {
  ThemeModeType _themeModeType = ThemeModeType.light;
  static const String _themeModeKey = 'theme_mode';

  ThemeProvider() {
    _loadThemeMode();
  }

  ThemeModeType get themeModeType => _themeModeType;

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final savedThemeMode = prefs.getString(_themeModeKey);
    if (savedThemeMode != null) {
      _themeModeType = ThemeModeType.values.firstWhere(
        (mode) => mode.toString() == savedThemeMode,
        orElse: () => ThemeModeType.light,
      );
      notifyListeners();
    }
  }

  Future<void> _saveThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_themeModeKey, _themeModeType.toString());
  }

  void setThemeMode(ThemeModeType mode) {
    _themeModeType = mode;
    notifyListeners();
    _saveThemeMode();
  }

  ThemeData get themeData {
    switch (_themeModeType) {
      case ThemeModeType.light:
        return ThemeData.light().copyWith(
          primaryColor: AfroReadsColors.background,
          primaryColorDark: AfroReadsColors.darkBackground,
          hintColor: AfroReadsColors.white
        );
      case ThemeModeType.dark:
        return ThemeData.dark().copyWith(
          primaryColor: AfroReadsColors.darkBackground,
           primaryColorDark: AfroReadsColors.background,
           hintColor: AfroReadsColors.semidarkBackground
        );
      case ThemeModeType.system:
        return ThemeData.light();
    }
  }
}

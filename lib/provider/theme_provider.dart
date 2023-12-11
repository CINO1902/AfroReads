import 'package:afroreads/core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
        return ThemeData(
            scaffoldBackgroundColor: Colors.white,
            primaryColor: AfroReadsColors.primaryColor,
            iconTheme: const IconThemeData(
              color: AfroReadsColors.primaryColor,
            ),
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: AfroReadsColors.primaryColor,
              selectionColor: AfroReadsColors.primaryColor,
            ),
            primaryColorLight: Colors.white,
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                  statusBarBrightness: Brightness.light,
                )),
            primaryColorDark: Colors.black,
            colorScheme: const ColorScheme.light(
              onBackground: Color.fromARGB(255, 114, 114, 114),
              onInverseSurface: Color.fromARGB(255, 224, 224, 224),
              onTertiary: Color.fromARGB(255, 255, 255, 255),
              primaryContainer: Colors.white,
            ));
      case ThemeModeType.dark:
        return ThemeData(
            scaffoldBackgroundColor: Color.fromARGB(255, 34, 34, 34),
            primaryColor: AfroReadsColors.primaryColor,
            primaryColorLight: Colors.black,
            textSelectionTheme: const TextSelectionThemeData(
              cursorColor: AfroReadsColors.primaryColor,
              selectionColor: AfroReadsColors.primaryColor,
            ),
            iconTheme: const IconThemeData(
              color: AfroReadsColors.primaryColor,
            ),
            appBarTheme: const AppBarTheme(
                backgroundColor: Colors.black,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarBrightness: Brightness.dark,
                    systemNavigationBarColor: Colors.black)),
            primaryColorDark: Colors.white,
            colorScheme: const ColorScheme.dark(
              onBackground: Color.fromARGB(255, 229, 229, 229),
              onTertiary: Color.fromARGB(255, 231, 231, 231),
              onInverseSurface: Color.fromARGB(255, 199, 199, 199),
              primaryContainer: Color.fromARGB(255, 28, 28, 28),
            ));
      case ThemeModeType.system:
        return ThemeData.light();
    }
  }
}

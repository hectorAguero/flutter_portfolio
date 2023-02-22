import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_mode_provider.g.dart';

final sharedPreferencesProvider =
    Provider<SharedPreferences>((ref) => throw UnimplementedError());

@Riverpod(keepAlive: true)
class DarkModeNotifier extends _$DarkModeNotifier {
  @override
  ThemeMode build() {
    ref.listenSelf((_, state) {
      ref.read(sharedPreferencesProvider).setInt("theme_mode", state.index);
    });
    return ThemeMode.values.elementAt(
        ref.read(sharedPreferencesProvider).getInt("theme_mode") ?? 0);
  }

  void toggle({required bool isSystemDarkMode}) {
    state = state.toggle(isSystemDarkMode);
  }
}

extension ToggleTheme on ThemeMode {
  ThemeMode toggle(bool isSystemDarkMode) {
    switch (this) {
      case ThemeMode.system:
        return isSystemDarkMode ? ThemeMode.light : ThemeMode.dark;
      case ThemeMode.dark:
        return isSystemDarkMode ? ThemeMode.system : ThemeMode.light;
      case ThemeMode.light:
        return !isSystemDarkMode ? ThemeMode.system : ThemeMode.dark;
    }
  }
}

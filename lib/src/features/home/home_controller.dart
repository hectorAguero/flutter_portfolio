import 'package:flutter_portfolio/src/router/app_router.dart';
import 'package:flutter_portfolio/src/screen_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:flutter_portfolio/src/theme_mode_provider.dart';

part 'home_controller.g.dart';

@riverpod
class HomeController extends _$HomeController {
  @override
  int build() {
    final location = ref.read(goRouterProvider).location;

    final index = AppRoutes.values
        .firstWhere((e) => e.tabname == location,
            orElse: () => AppRoutes.aboutme)
        .index;
    return index;
  }

  void toggleTheme(bool isSystemDarkMode) {
    ref
        .read(darkModeNotifierProvider.notifier)
        .toggle(isSystemDarkMode: isSystemDarkMode);
  }

  void changeIndex(int index) {
    state = index;
  }
}

@riverpod
class DrawerNotifier extends _$DrawerNotifier {
  @override
  bool build(bool isDesktop) {
    return isDesktop;
  }

  void toggle() {
    state = !state;
  }
}

final screenSizeProvider = StateProvider<ScreenSize>((ref) {
  throw UnimplementedError();
});

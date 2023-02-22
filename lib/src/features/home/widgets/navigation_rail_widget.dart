import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_portfolio/src/features/home/home_controller.dart';
import 'package:flutter_portfolio/src/theme_mode_provider.dart';
import 'package:flutter_portfolio/src/screen_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationRailWidget extends ConsumerWidget {
  const NavigationRailWidget({Key? key, required this.destinations})
      : super(key: key);
  final List<NavigationRailDestination> destinations;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationRail(
      extended: context.isDesktop &&
          ref.watch(drawerNotifierProvider(context.isDesktop)),
      destinations: destinations,
      selectedIndex: ref.watch(homeControllerProvider),
      leading: const NavigationLeadingButton(),
      onDestinationSelected: (value) =>
          ref.read(homeControllerProvider.notifier).changeIndex(value),
      trailing: const Expanded(
        child: Align(
          alignment: Alignment.bottomLeft,
          child: NavigationRailMenuButton(),
        ),
      ),
    );
  }
}

class NavigationLeadingButton extends ConsumerStatefulWidget {
  const NavigationLeadingButton({super.key});

  @override
  ConsumerState<NavigationLeadingButton> createState() =>
      _NavigationLeadingButtonState();
}

class _NavigationLeadingButtonState
    extends ConsumerState<NavigationLeadingButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final Animation<double> animation =
        NavigationRail.extendedAnimation(context);
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Padding(
            padding: EdgeInsets.only(
              right: lerpDouble(0, 0, animation.value)!,
            ),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border.all(
                    color: theme.colorScheme.inversePrimary, width: 2.0),
                color: Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: FloatingActionButton.extended(
                heroTag: 'menu',
                label: const Text('Menu'),
                isExtended: animation.value == 1.0,
                icon: const Icon(Icons.menu),
                onPressed: () {
                  ref
                      .read(drawerNotifierProvider(context.isDesktop).notifier)
                      .toggle();
                },
              ),
            ),
          ),
        );
      },
    );
  }
}

class NavigationRailMenuButton extends ConsumerWidget {
  const NavigationRailMenuButton({super.key, this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(darkModeNotifierProvider);
    final Animation<double> animation =
        NavigationRail.extendedAnimation(context);
    return AnimatedBuilder(
      animation: animation,
      builder: (BuildContext context, Widget? child) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: FloatingActionButton.extended(
            label: Text(
                'Theme ${themeMode.name.substring(0, 1).toUpperCase()}${themeMode.name.substring(1)}'),
            isExtended: animation.value == 1.0,
            icon: themeMode == ThemeMode.system
                ? Icon(theme.brightness == Brightness.light
                    ? Icons.light_mode
                    : Icons.dark_mode)
                : themeMode == ThemeMode.light
                    ? const Icon(Icons.light_mode_outlined)
                    : const Icon(Icons.dark_mode_outlined),
            onPressed: () {
              ref.read(homeControllerProvider.notifier).toggleTheme(
                  MediaQuery.platformBrightnessOf(context) == Brightness.dark);
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_portfolio/src/features/home/home_controller.dart';
import 'package:flutter_portfolio/src/features/home/showcase/showcase_page.dart';
import 'package:flutter_portfolio/src/features/home/about_me/about_me_page.dart';
import 'package:flutter_portfolio/src/features/home/technologies/technologies_page.dart';
import 'package:flutter_portfolio/src/features/home/widgets/navigation_bar_widget.dart';
import 'package:flutter_portfolio/src/features/home/widgets/navigation_rail_widget.dart';
import 'package:flutter_portfolio/src/localization/extensions.dart';
import 'package:flutter_portfolio/src/router/app_router.dart';
import 'package:flutter_portfolio/src/theme_mode_provider.dart';
import 'package:flutter_portfolio/src/screen_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'contact/contact_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeMode = ref.watch(darkModeNotifierProvider);
    ref.watch(drawerNotifierProvider(context.isDesktop));
    ref.listen(homeControllerProvider, (_, index) {
      GoRouter.of(context).goNamed(AppRoutes.values[index].name);
    });
    return Scaffold(
      appBar: context.isMobile
          ? AppBar(
              leading: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: FlutterLogo(),
              ),
              actions: [
                IconButton(
                  color: themeMode == ThemeMode.system
                      ? theme.colorScheme.primary
                      : null,
                  icon: themeMode == ThemeMode.system
                      ? Icon(theme.brightness == Brightness.light
                          ? Icons.light_mode
                          : Icons.dark_mode)
                      : themeMode == ThemeMode.light
                          ? const Icon(Icons.light_mode_outlined)
                          : const Icon(Icons.dark_mode_outlined),
                  onPressed: () {
                    ref.read(homeControllerProvider.notifier).toggleTheme(
                        MediaQuery.platformBrightnessOf(context) ==
                            Brightness.dark);
                  },
                ),
              ],
            )
          : null,
      body: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          if (!context.isMobile)
            NavigationRailWidget(
              destinations: _destinations
                  .map((e) => NavigationRailDestination(
                        icon: e.icon,
                        selectedIcon: e.selectedIcon,
                        label: Text(e.label),
                      ))
                  .toList(),
            ),
          const VerticalDivider(
            width: 1,
            thickness: 0,
          ),
          Expanded(
            child: IndexedStack(
              sizing: StackFit.expand,
              index: ref.watch(homeControllerProvider),
              children: const [
                AboutMePage(),
                ShowcasePage(),
                TechnologiesPage(),
                ContactPage(),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: context.isMobile
          ? NavigationBarWidget(destinations: _destinations)
          : null,
    );
  }
}

List<NavigationDestination> _destinations = [
  NavigationDestination(
    tooltip: 'About'.hardcoded,
    icon: const Icon(Icons.person_outline),
    label: 'About Me'.hardcoded,
    selectedIcon: const Icon(Icons.person),
  ),
  NavigationDestination(
    tooltip: 'Showcase'.hardcoded,
    icon: const Icon(Icons.app_registration_outlined),
    label: 'Showcase'.hardcoded,
    selectedIcon: const Icon(Icons.app_registration),
  ),
  NavigationDestination(
    tooltip: 'Other Languages'.hardcoded,
    icon: const Icon(Icons.mobile_screen_share_outlined),
    label: 'Tech'.hardcoded,
    selectedIcon: const Icon(Icons.mobile_screen_share),
  ),
  NavigationDestination(
    tooltip: 'Contact'.hardcoded,
    icon: const Icon(Icons.contact_page_outlined),
    label: 'Contact'.hardcoded,
    selectedIcon: const Icon(Icons.contact_page),
  )
];

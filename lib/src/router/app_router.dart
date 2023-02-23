import 'package:flutter/widgets.dart';
import 'package:flutter_portfolio/src/error/not_found_page.dart';
import 'package:flutter_portfolio/src/features/home/about_me/about_me_page.dart';
import 'package:flutter_portfolio/src/features/home/contact/contact_page.dart';
import 'package:flutter_portfolio/src/features/home/home_page.dart';
import 'package:flutter_portfolio/src/features/home/showcase/showcase_page.dart';
import 'package:flutter_portfolio/src/features/home/technologies/technologies_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

enum AppRoutes {
  aboutme,
  showcase,
  technologies,
  contact;
}

extension AppRoutesExtension on AppRoutes {
  String get tabname => '/$name';
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _shellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell');

final goRouterProvider = Provider<GoRouter>(
  (ref) {
    return GoRouter(
      initialLocation: AppRoutes.aboutme.tabname,
      redirect: (context, state) {
        if (state.location.isEmpty &&
            state.extra.toString() == 'not_found_page') {
          return AppRoutes.aboutme.tabname;
        }
        return null;
      },
      navigatorKey: _rootNavigatorKey,
      debugLogDiagnostics: true,
      errorBuilder: (BuildContext context, GoRouterState state) =>
          NotFoundPage(state.error!),
      routes: [
        ShellRoute(
          navigatorKey: _shellNavigatorKey,
          pageBuilder: (context, state, child) {
            return const NoTransitionPage(child: HomePage());
          },
          routes: [
            GoRoute(
              path: AppRoutes.aboutme.tabname,
              name: AppRoutes.aboutme.name,
              builder: (BuildContext context, GoRouterState state) {
                return const AboutMePage();
              },
            ),
            GoRoute(
              path: AppRoutes.technologies.tabname,
              name: AppRoutes.technologies.name,
              builder: (BuildContext context, GoRouterState state) {
                return const TechnologiesPage();
              },
            ),
            GoRoute(
              path: AppRoutes.showcase.tabname,
              name: AppRoutes.showcase.name,
              builder: (BuildContext context, GoRouterState state) {
                return const ShowcasePage();
              },
            ),
            GoRoute(
              path: AppRoutes.contact.tabname,
              name: AppRoutes.contact.name,
              builder: (BuildContext context, GoRouterState state) {
                return const ContactPage();
              },
            )
          ],
        )
      ],
    );
  },
);

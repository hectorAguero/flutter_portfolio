import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_portfolio/src/features/home/home_controller.dart';
import 'package:flutter_portfolio/src/localization/extensions.dart';
import 'package:flutter_portfolio/src/error/async_error_logger.dart';
import 'package:flutter_portfolio/src/error/error_logger.dart';
import 'package:flutter_portfolio/src/router/app_router.dart';
import 'package:flutter_portfolio/src/screen_sizes.dart';
import 'package:flutter_portfolio/src/theme_mode_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:material_color_utilities/material_color_utilities.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final CorePalette? corePalette = await DynamicColorPlugin.getCorePalette();
  Color? accentColor;
  if (corePalette == null) {
    accentColor = await DynamicColorPlugin.getAccentColor();
  }
  final width =
      MediaQueryData.fromWindow(WidgetsBinding.instance.window).size.width;
  // * Create ProviderContainer with any required overrides
  final container = ProviderContainer(
    overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      screenSizeProvider.overrideWith((ref) => ScreenSize.current(width)),
    ],
    observers: [AsyncErrorLogger()],
  );
  final errorLogger = container.read(errorLoggerProvider);
  // * Register error handlers. For more info, see:
  // * https://docs.flutter.dev/testing/errors
  registerErrorHandlers(errorLogger);
  // * Entry point of the app

  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: MyApp(
        corePalette: corePalette,
        colorAccent: accentColor,
      ),
    ),
  );
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp(
      {required this.corePalette, required this.colorAccent, super.key});
  final CorePalette? corePalette;
  final Color? colorAccent;
  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  Widget build(BuildContext context) {
    final router = ref.watch(goRouterProvider);
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      title: 'Flutter Portfolio'.hardcoded,
      themeMode: ref.watch(darkModeNotifierProvider),
      theme: ThemeData.from(
        colorScheme: (widget.corePalette?.toColorScheme() ??
                ColorScheme.fromSeed(
                    seedColor: widget.colorAccent ?? Colors.pink))
            .harmonized(),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.from(
        useMaterial3: true,
        colorScheme:
            (widget.corePalette?.toColorScheme(brightness: Brightness.dark) ??
                    ColorScheme.fromSeed(
                        seedColor: widget.colorAccent ?? Colors.pink,
                        brightness: Brightness.dark))
                .harmonized(),
      ),
    );
  }
}

void registerErrorHandlers(ErrorLogger errorLogger) {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FlutterError.presentError(details);
    errorLogger.logError(details.exception, details.stack);
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    errorLogger.logError(error, stack);
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('An error occurred'.hardcoded),
      ),
      body: Center(child: Text(details.toString())),
    );
  };
}

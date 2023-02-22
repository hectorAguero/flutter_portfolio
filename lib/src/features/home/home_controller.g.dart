// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$homeControllerHash() => r'f10e336b187113c36b20d56fe6e61d9c605ca561';

/// See also [HomeController].
@ProviderFor(HomeController)
final homeControllerProvider =
    AutoDisposeNotifierProvider<HomeController, int>.internal(
  HomeController.new,
  name: r'homeControllerProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$homeControllerHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$HomeController = AutoDisposeNotifier<int>;
String _$drawerNotifierHash() => r'20338bf69256e2be21b7092bcd45d992d26298bf';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$DrawerNotifier extends BuildlessAutoDisposeNotifier<bool> {
  late final bool isDesktop;

  bool build(
    bool isDesktop,
  );
}

/// See also [DrawerNotifier].
@ProviderFor(DrawerNotifier)
const drawerNotifierProvider = DrawerNotifierFamily();

/// See also [DrawerNotifier].
class DrawerNotifierFamily extends Family<bool> {
  /// See also [DrawerNotifier].
  const DrawerNotifierFamily();

  /// See also [DrawerNotifier].
  DrawerNotifierProvider call(
    bool isDesktop,
  ) {
    return DrawerNotifierProvider(
      isDesktop,
    );
  }

  @override
  DrawerNotifierProvider getProviderOverride(
    covariant DrawerNotifierProvider provider,
  ) {
    return call(
      provider.isDesktop,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'drawerNotifierProvider';
}

/// See also [DrawerNotifier].
class DrawerNotifierProvider
    extends AutoDisposeNotifierProviderImpl<DrawerNotifier, bool> {
  /// See also [DrawerNotifier].
  DrawerNotifierProvider(
    this.isDesktop,
  ) : super.internal(
          () => DrawerNotifier()..isDesktop = isDesktop,
          from: drawerNotifierProvider,
          name: r'drawerNotifierProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$drawerNotifierHash,
          dependencies: DrawerNotifierFamily._dependencies,
          allTransitiveDependencies:
              DrawerNotifierFamily._allTransitiveDependencies,
        );

  final bool isDesktop;

  @override
  bool operator ==(Object other) {
    return other is DrawerNotifierProvider && other.isDesktop == isDesktop;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, isDesktop.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  bool runNotifierBuild(
    covariant DrawerNotifier notifier,
  ) {
    return notifier.build(
      isDesktop,
    );
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions

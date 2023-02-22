import 'package:flutter/material.dart';
import 'package:flutter_portfolio/src/features/home/home_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavigationBarWidget extends ConsumerWidget {
  const NavigationBarWidget({Key? key, required this.destinations})
      : super(key: key);
  final List<Widget> destinations;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NavigationBar(
        height: 100,
        destinations: destinations,
        onDestinationSelected: (value) =>
            ref.read(homeControllerProvider.notifier).changeIndex(value),
        selectedIndex: ref.watch(homeControllerProvider));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_portfolio/src/features/home/showcase/showcase_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedFeature extends ConsumerWidget {
  const SelectedFeature({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final index = ref.watch(showcaseControllerProvider);

    return SizedBox(
      key: ValueKey<String>(index?.route ?? "No feature selected"),
      child: index != null
          ? index.widget
          : const Center(child: Text('No feature selected')),
    );
  }
}

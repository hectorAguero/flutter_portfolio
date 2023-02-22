import 'package:flutter/material.dart';
import 'package:flutter_portfolio/src/features/home/showcase/widgets/selected_feature.dart';
import 'package:flutter_portfolio/src/screen_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SelectedFeaturePage extends ConsumerWidget {
  const SelectedFeaturePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return NotificationListener<SizeChangedLayoutNotification>(
      onNotification: (notification) {
        if (!context.isMobile) Navigator.of(context).maybePop();
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            transitionBuilder: (
              Widget child,
              Animation<double> primaryAnimation,
            ) {
              return FadeTransition(
                opacity: primaryAnimation,
                child: child,
              );
            },
            child: const SelectedFeature()),
      ),
    );
  }
}

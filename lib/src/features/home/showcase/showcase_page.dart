import 'package:flutter/material.dart';
import 'package:flutter_portfolio/src/features/home/showcase/showcase_controller.dart';
import 'package:flutter_portfolio/src/features/home/showcase/widgets/selected_feature.dart';
import 'package:flutter_portfolio/src/features/home/showcase/widgets/selected_feature_page.dart';
import 'package:flutter_portfolio/src/screen_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ShowcasePage extends ConsumerWidget {
  const ShowcasePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: ListView.builder(
              itemCount: 20,
              padding: const EdgeInsets.all(8),
              itemBuilder: (context, index) {
                final featureList = ref.watch(showCaseFeatureProvider);
                final feature =
                    featureList.length > index ? featureList[index] : null;
                final indexFeature =
                    ref.watch(showcaseFeatureIndexProvider) == index;
                return SizedBox(
                  height: 80,
                  //tamaño falso, error flutter
                  width: 400,
                  child: ListTile(
                    shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    selected: indexFeature && !context.isMobile,
                    minLeadingWidth: 64,
                    title: Text(
                      feature?.title ?? 'Not Implemented',
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                          fontSize: feature != null ? 16 : 12,
                          fontWeight: feature != null
                              ? FontWeight.bold
                              : FontWeight.normal),
                    ),
                    subtitle: Text(
                      feature?.description ?? '...',
                      maxLines: 1,
                      overflow: TextOverflow.fade,
                    ),
                    selectedTileColor: Theme.of(context).highlightColor,
                    leading: SizedBox(
                      width: 48,
                      child: CircleAvatar(
                        radius: 24,
                        child: Text(
                          '${index + 1}',
                        ),
                      ),
                    ),
                    onTap: () {
                      ref
                          .read(showcaseControllerProvider.notifier)
                          .setIndex(index);
                      if (context.isMobile && feature != null) {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Scaffold(
                                appBar: AppBar(
                                  title: Text(feature.title),
                                ),
                                body: const SelectedFeaturePage())));
                      }
                    },
                  ),
                );
              },
            ),
          ),
          if (!context.isMobile)
            Expanded(
              flex: 3,
              child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                  child: const SelectedFeature()),
            ),
        ],
      ),
    );
  }
}

import 'package:flutter_portfolio/src/features/animations_show/animation_show_page.dart';
import 'package:flutter_portfolio/src/features/home/showcase/feature_model.dart';
import 'package:flutter_portfolio/src/features/photo_gallery/photo_gallery_page.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'showcase_controller.g.dart';

@riverpod
class ShowcaseController extends _$ShowcaseController {
  @override
  FeatureModel? build() {
    return null;
  }

  void setIndex(int index) {
    final features = ref.read(showCaseFeatureProvider);
    if (index < 0 || index >= features.length) {
      state = null;
    } else {
      state = features.elementAt(index);
    }
  }
}

final showcaseFeatureIndexProvider = StateProvider.autoDispose<int?>((ref) {
  final list = ref.watch(showCaseFeatureProvider);
  final index = ref.watch(showcaseControllerProvider);

  if (index != null) {
    return list.indexOf(index);
  }
  return null;
});

final showCaseFeatureProvider = Provider<List<FeatureModel>>((ref) {
  return <FeatureModel>[
    FeatureModel(
      route: '/photo_gallery',
      widget: const PhotoGalleryPage(),
      title: 'Photo Gallery',
      description: 'Simple API call to Unsplash',
    ),
    FeatureModel(
      route: '/animation_show',
      widget: const AnimationShowPage(),
      title: 'Animation Gallery',
      description: 'Simple Animations Widgets',
    ),
  ];
});

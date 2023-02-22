import 'package:flutter/material.dart';
import 'package:flutter_portfolio/src/features/photo_gallery/photo_gallery_controller.dart';
import 'package:flutter_portfolio/src/screen_sizes.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PhotoGalleryPage extends ConsumerStatefulWidget {
  const PhotoGalleryPage({Key? key}) : super(key: key);
  @override
  ConsumerState<PhotoGalleryPage> createState() => _PhotoGalleryState();
}

class _PhotoGalleryState extends ConsumerState<PhotoGalleryPage> {
  bool _onScrollNotification(ScrollNotification notification) {
    if (notification is ScrollEndNotification) {
      final before = notification.metrics.extentBefore;
      final max = notification.metrics.maxScrollExtent;

      if (before == max &&
          !ref.read(photoGalleryControllerProvider).isLoading) {
        ref.read(photoGalleryControllerProvider.notifier).loadMore();
        // load next page
        // code here will be called only if scrolled to the very bottom
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final photoProvider = ref.watch(photoGalleryControllerProvider);
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        heroTag: 'changePhotoApi',
        onPressed: photoProvider.isLoading
            ? null
            : () {
                ref
                    .read(photoGalleryControllerProvider.notifier)
                    .changePhotoApi();
              },
        icon: const Icon(Icons.api_outlined),
        label: !photoProvider.isLoading
            ? const Text('Change Photo API')
            : const Text('Making an API call...'),
      ),
      body: ref.watch(photoGalleryControllerProvider).when(
            data: (data) {
              return RefreshIndicator(
                onRefresh: () =>
                    ref.refresh(photoGalleryControllerProvider.future),
                child: NotificationListener(
                  onNotification: _onScrollNotification,
                  child: CustomScrollView(
                    slivers: [
                      if (!context.isMobile)
                        const SliverAppBar(
                          pinned: true,
                          title: Text('Photo Gallery'),
                        ),
                      SliverGrid.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: context.isDesktop ? 2 : 1,
                        ),
                        itemBuilder: (context, index) {
                          return Image.network(
                            data[index],
                            fit: BoxFit.cover,
                          );
                        },
                        itemCount: data.length,
                      ),
                      SliverToBoxAdapter(
                          child: Center(
                              child: Center(
                        child: SizedBox(
                            height: 80,
                            child: Column(
                              children: const [
                                SizedBox(height: 16),
                                CircularProgressIndicator.adaptive(),
                                SizedBox(height: 16),
                                Text('Loading more...'),
                              ],
                            )),
                      )))
                    ],
                  ),
                ),
              );
            },
            error: (error, stack) => const Center(child: Text('Error')),
            loading: () => const Center(child: CircularProgressIndicator()),
          ),
    );
  }
}

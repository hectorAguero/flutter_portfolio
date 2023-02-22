import 'package:flutter_portfolio/src/dio_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'photo_gallery_controller.g.dart';

@riverpod
class PhotoGalleryController extends _$PhotoGalleryController {
  final bool canLoadMore = true;

  @override
  FutureOr<List<String>> build() {
    return loadPhotos();
  }

  Future<List<String>> loadPhotos() async {
    List<String> listPhotos = <String>[];
    final selectedApi = ref.read(photoGalleryApiNotifierProvider);
    for (var i = 0; i < 10; i++) {
      final response = await ref
          .read(dioNotifierProvider)
          .get(selectedApi, queryParameters: {'sig': '$i'});
      await Future.delayed(const Duration(milliseconds: 1));
      listPhotos.add(response.realUri.toString());
    }
    return listPhotos;
  }

  Future<void> changePhotoApi() async {
    state = const AsyncLoading<List<String>>().copyWithPrevious(state);
    ref.read(photoGalleryApiNotifierProvider.notifier).changePhotoApi();
    final listPhotos = await loadPhotos();
    state = AsyncData(listPhotos);
  }

  Future<List<String>> loadMore() async {
    state = const AsyncLoading<List<String>>().copyWithPrevious(state);
    final listPhotos = await loadPhotos();
    state = AsyncData([...state.value!, ...listPhotos]);
    return listPhotos;
  }
}

@riverpod
class PhotoGalleryApiNotifier extends _$PhotoGalleryApiNotifier {
  final photoApiList = [
    'https://source.unsplash.com/random',
    'https://picsum.photos/200/300',
    'https://loremflickr.com/320/240',
    'https://placeimg.com/640/480/any',
    'https://placekitten.com/200/300',
    'https://placebeard.it/200/300',
    'https://placebear.com/200/300',
  ];

  @override
  String build() {
    return photoApiList[0];
  }

  void changePhotoApi() {
    if (state == photoApiList.last) {
      state = photoApiList.first;
    } else {
      state = photoApiList[photoApiList.indexOf(state) + 1];
    }
  }
}

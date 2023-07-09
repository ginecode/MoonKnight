import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:tamannaah/darkknight/debug_functions.dart';

import 'auth.dart';
import 'delete_comment.dart';
import 'delete_post.dart';
import 'image_upload.dart';
import 'send_comment.dart';

part 'loading.g.dart';

@riverpod
bool isLoading(IsLoadingRef ref) {
  final authState = ref.watch(authProvider);
  final isUploadingImage = ref.watch(imageUploadProvider);
  final isSendingComment = ref.watch(sendCommentProvider);
  final isDeletingComment = ref.watch(deleteCommentProvider);
  final isDeletingPost = ref.watch(deletePostProvider);

  dino(
    'Is Loading : '
    'Auth : ${authState.isLoading}'
    'Image : $isUploadingImage'
    'sComment : $isSendingComment'
    'dComment : $isDeletingComment'
    'dPost : $isDeletingPost'
    'Final : ${authState.isLoading || isUploadingImage || isSendingComment || isDeletingComment || isDeletingPost}',
  );

  return authState.isLoading || isUploadingImage || isSendingComment || isDeletingComment || isDeletingPost;
}

@riverpod
class Onion extends _$Onion {
  @override
  bool build() {
    return false;
  }

  void onionTrue() {
    state = !state;
  }
}

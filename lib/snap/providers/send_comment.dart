import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moonknight/insta/state/comments/models/comment_payload.dart';
import 'package:moonknight/insta/state/constants/firebase_collection_name.dart';
import 'package:moonknight/insta/state/posts/typedefs/post_id.dart';
import 'package:moonknight/insta/state/posts/typedefs/user_id.dart';

part 'send_comment.g.dart';

@riverpod
class SendComment extends _$SendComment {
  @override
  bool build() {
    return false;
  }

  set isLoading(bool value) => state = value;

  Future<bool> sendComment({
    required UserId fromUserId,
    required PostId onPostId,
    required String comment,
  }) async {
    isLoading = true;
    final payload = CommentPayload(
      fromUserId: fromUserId,
      onPostId: onPostId,
      comment: comment,
    );
    try {
      await FirebaseFirestore.instance.collection(FirebaseCollectionName.comments).add(payload);
      return true;
    } catch (_) {
      return false;
    } finally {
      isLoading = false;
    }
  }
}

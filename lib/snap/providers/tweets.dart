import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moonknight/snap/providers/rooms.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:moonknight/models/lib/chat.pb.dart';
import 'auth.dart';

part 'tweets.g.dart';

@riverpod
class TweetList extends _$TweetList {
  @override
  List<Tweet?> build() {
    ref.onDispose(() {
      log('Tweet Dispose');
    });

    ref.listenSelf((previous, next) {
      log('Prev : ${previous?.length}   Next : ${next.length}');
    });

    ref.listen(currentRoomProvider, (previous, next) {
      int? previousCount = previous?.value?.tweetCount;
      int? nextCount = next.value?.tweetCount;
      if (previousCount != null && nextCount != null && previousCount < nextCount) {
        fetch10Tweets(count: nextCount - previousCount);
      }
    });

    ref.onCancel(() {
      log('Tweet Cancel');
    });

    ref.onResume(() {
      log('Tweet Resume');
    });

    log('Tweet List Build');
    fetch10Tweets(initialized: false);
    return [];
  }

  void _add(Tweet tweet) {
    final l = state.map((e) => e).toList();
    l.insert(0, tweet);
    state = l;
    log('add : ${state.length}');
  }

  void _remove(Tweet tweet) {
    final l = state.map((e) => e).toList();
    l.remove(tweet);
    state = l;
    log('rem : ${state.length}');
  }

  void _addAll(List<Tweet?> tweets) {
    final l = state.map((e) => e).toList();
    l.addAll(tweets);
    state = l;
    log('addAll : ${state.length}');
  }

  FutureOr<List<Tweet?>?> fetch10Tweets({
    bool initialized = true,
    int count = 0,
  }) async {
    final currentRoom = ref.read(currentRoomProvider).value;

    Query<Tweet?>? query =
        currentRoom?.tweetCol?.limit(count == 0 ? 10 : count).orderBy(Const.created.name, descending: true);

    if (initialized && count == 0) {
      DocumentSnapshot<Tweet?>? documentSnapshot = await currentRoom?.tweetCol
          ?.doc(
            state.last?.id,
          )
          .get();

      if (documentSnapshot != null) {
        query = query?.startAfterDocument(documentSnapshot);
      }
    }

    final tweets = await query?.get().then(
          (value) => value.docs
              .map(
                (e) => e.data()?..id = e.id,
              )
              .toList(),
        );

    log('Fetch10Tweets :  ${tweets?.length} : $query ');

    if (tweets != null) {
      _addAll(tweets);
      log('Tweet List len : ${state.length}');
    }

    return tweets;
  }

  FutureOr<void> sendTweet({
    required String text,
    String? link,
    MediaType type = MediaType.TEXT,
  }) async {
    final currentUser = ref.read(currentUserProvider).value!;
    final currentRoom = ref.read(currentRoomProvider).value;

    if (!ref.read(isUserIsInRoomProvider)) {
      throw Exception('You shall not pass.');
    }

    Tweet tweet = Tweet(
      senderId: currentUser.id,
      roomId: currentRoom?.id,
      mediaType: type,
      text: text,
      link: link,
      created: DateTime.now().toIso8601String(),
    );

    log(tweet.toString());

    await currentRoom?.tweetCol?.add(tweet);

    await currentRoom?.roomDoc.update({
      Const.tweet_count.name: FieldValue.increment(1),
    });

    _add(tweet);
  }

  FutureOr<void> deleteTweet(Tweet tweet) async {
    final currentUser = ref.read(currentUserProvider).value!;
    final currentRoom = ref.read(currentRoomProvider).value;

    if (tweet.senderId != currentUser.id) throw (Exception('You shall not pass.'));

    await currentRoom?.tweetCol?.doc(tweet.id).delete();

    await currentRoom?.roomDoc.update({
      Const.tweet_count.name: FieldValue.increment(-1),
    });

    _remove(tweet);
  }
}

// void editTweet() {
// }

// void reactOnTween() {
// }


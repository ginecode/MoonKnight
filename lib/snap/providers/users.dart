import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moonknight/models/lib/chat.pb.dart';
import 'package:moonknight/snap/proto_help/utils.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'users.g.dart';

@riverpod
Future<List<User?>> getAllUsers(GetAllUsersRef ref) async {
  log('Get All Users');
  ref.onDispose(() {
    log('Dispose');
  });
  ref.onCancel(() {
    log('Cancel'.toString());
  });

  // log(fa.FirebaseAuth.instance.currentUser.toString());

  final hello = await FirebaseFirestore.instance
      .collection(
        Const.users.name,
      )
      .get();
  log('Length : ${hello.docs.length}');

  return FirebaseFirestore.instance.collection(Const.users.name).get().then(
    (value) {
      log(value.docs.length.toString());
      return value.docs.map(
        (e) {
          log('-------------------------');
          log('${e.id} : ${e.data()}');
          log('-------------------------');

          return fromQuerySnap(User(), e);
        },
      ).toList();
    },
    onError: (e) {
      log(e);
    },
  );
}

@riverpod
FutureOr<User?> getUserById(GetUserByIdRef ref, String userId) async {
  final hello = await FirebaseFirestore.instance
      .collection(
        Const.users.name,
      )
      .doc(userId)
      .get();
  return fromDocSnap(User(), hello);
}

@riverpod
FutureOr<User?> getUserByPhone(GetUserByPhoneRef ref, String phone) async {
  final hello = await FirebaseFirestore.instance
      .collection(Const.users.name)
      .where(
        Const.phone.name,
        isEqualTo: phone,
      )
      .get();
  final userList = hello.docs.map((e) => fromQuerySnap(User(), e));
  if (userList.isNotEmpty) return userList.first;
  return null;
}

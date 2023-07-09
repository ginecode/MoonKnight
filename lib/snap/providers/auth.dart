import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:moonknight/insta/state/auth/backend/authenticator.dart';
import 'package:moonknight/insta/state/auth/models/auth_result.dart';
import 'package:moonknight/models/lib/chat.pb.dart';
import 'package:moonknight/snap/proto_help/utils.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tamannaah/darkknight/debug_functions.dart';

part 'auth.g.dart';

@Riverpod(keepAlive: true)
Stream<User?> currentUser(CurrentUserRef ref) {
  return auth.FirebaseAuth.instance.userChanges().map(
        (auth.User? u) => u != null
            ? User(
                id: u.uid,
                nam: u.displayName,
                email: u.email,
                avatar: u.photoURL,
                phone: u.phoneNumber,
              )
            : null,
      );
}

@riverpod
class Auth extends _$Auth {
  final _authenticator = const Authenticator();

  @override
  FutureOr<User?> build() async {
    return null;
  }

  Future<void> logOut() async {
    state = const AsyncValue.loading();
    await _authenticator.logOut();
    if (!_authenticator.isAlreadyLoggedIn) {
      state = const AsyncValue.data(null);
    }
  }

  Future<void> deleteAccount() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _authenticator.deleteAccount();
      if (!_authenticator.isAlreadyLoggedIn) {
        return null;
      }
      throw Exception('Delete Account Failed');
    });
  }

  Future<void> anonymousLogin() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _authenticator.loginAnonymously();
        final userId = _authenticator.user?.uid;
        dino(userId.toString());
        if (_authenticator.isAlreadyLoggedIn) {
          return saveUserInfo();
        }
        throw Exception('Anonymous Login Failed');
      },
    );
  }

  Future<void> createUserWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _authenticator.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        final userId = _authenticator.user?.uid;
        dino('Create User : $userId');
        if (_authenticator.isAlreadyLoggedIn) {
          return saveUserInfo();
        }
        throw Exception('Create User With Email And Password Failed');
      },
    );
  }

  Future<void> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _authenticator.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        final userId = _authenticator.user?.uid;
        dino('Sign In : $userId');
        if (_authenticator.isAlreadyLoggedIn) {
          return saveUserInfo();
        }
        throw Exception('Sign In With Email And Password Failed');
      },
    );
  }

  Future<void> loginWithGoogle() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _authenticator.loginWithGoogle();
        final userId = _authenticator.user?.uid;
        dino('Log In : $userId');
        if (_authenticator.isAlreadyLoggedIn) {
          return saveUserInfo();
        }
        throw Exception('Login With Google Failed');
      },
    );
  }

  Future<void> loginWithFacebook() async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () async {
        await _authenticator.loginWithFacebook();
        final userId = _authenticator.user?.uid;
        dino('Log In : $userId');
        if (_authenticator.isAlreadyLoggedIn) {
          return saveUserInfo();
        }
        throw Exception('Login With Facebook Failed');
      },
    );
  }

  Future<User?> saveUserInfo() async {
    try {
      // first check if we have this user's info from before
      final docuser = await getSavedUser();
      final user = docuser.user;

      // final doc = docuser.doc;
      // //For Anonymous Login
      // if (user != null) {
      //   await doc?.reference.set(
      //     User(
      //       id: _authenticator.user?.uid,
      //       nam: _authenticator.user?.displayName,
      //       email: _authenticator.user?.email,
      //       avatarUrl: _authenticator.user?.photoURL,
      //     ).toMap()!,
      //     SetOptions(merge: true),
      //   );
      // }

      if (user == null) {
        await FirebaseFirestore.instance
            .collection(Const.users.name)
            .doc(_authenticator.user?.uid)
            .set(
              User(
                nam: _authenticator.user?.displayName,
                email: _authenticator.user?.email,
                avatar: _authenticator.user?.photoURL,
              ).toMap()!,
            )
            .then(
          (value) => null,
          onError: (e) {
            lava(e);
          },
        );

        return (await getSavedUser()).user;
      }
    } catch (e, s) {
      lava('$e $s');
    }
    return null;
  }

  Future<({QueryDocumentSnapshot<Map<String, dynamic>>? doc, User? user})> getSavedUser() async {
    final QuerySnapshot<Map<String, dynamic>> userInfo = await FirebaseFirestore.instance
        .collection(
          Const.users.name,
        )
        .where(
          Const.id.name,
          isEqualTo: _authenticator.user?.uid,
        )
        .limit(1)
        .get();

    return (
      doc: userInfo.docs.firstOrNull,
      user: userInfo.docs.firstOrNull != null
          ? User.fromJson(
              json.encode(
                userInfo.docs.firstOrNull?.data(),
              ),
            )
          : null
    );
  }

  void phoneLogin(BuildContext context, String phone) async {
    // state = const AsyncValue.loading();
    final result = await _authenticator.loginWithPhone(context, phone);

    dino(result.toString());

    if (result == AuthResult.success) {
      state = await AsyncValue.guard(
        () async {
          final userId = _authenticator.user?.uid;
          dino('Log In : $userId : $result');
          if (_authenticator.isAlreadyLoggedIn) {
            return saveUserInfo();
          }
          return null;
        },
      );
    }
  }
}

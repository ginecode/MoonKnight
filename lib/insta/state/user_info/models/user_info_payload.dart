import 'dart:collection' show MapView;

import 'package:flutter/foundation.dart' show immutable;
import 'package:moonknight/insta/state/constants/firebase_field_name.dart';
import 'package:moonknight/insta/state/posts/typedefs/user_id.dart';

@immutable
class UserInfoPayload extends MapView<String, String> {
  final UserId userId;
  final String? displayName;
  final String? email;

  UserInfoPayload({
    required this.userId,
    required this.displayName,
    required this.email,
  }) : super(
          {
            FirebaseFieldName.userId: userId,
            FirebaseFieldName.displayName: displayName ?? '',
            FirebaseFieldName.email: email ?? '',
          },
        );
}

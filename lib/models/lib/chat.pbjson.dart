///
//  Generated code. Do not modify.
//  source: lib/chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,deprecated_member_use_from_same_package,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;
import 'dart:convert' as $convert;
import 'dart:typed_data' as $typed_data;
@$core.Deprecated('Use roleDescriptor instead')
const Role$json = const {
  '1': 'Role',
  '2': const [
    const {'1': 'BLOCKED', '2': 0},
    const {'1': 'DENIED', '2': 10},
    const {'1': 'REQUEST', '2': 20},
    const {'1': 'USER', '2': 30},
    const {'1': 'MODERATOR', '2': 40},
    const {'1': 'ADMIN', '2': 50},
  ],
};

/// Descriptor for `Role`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List roleDescriptor = $convert.base64Decode('CgRSb2xlEgsKB0JMT0NLRUQQABIKCgZERU5JRUQQChILCgdSRVFVRVNUEBQSCAoEVVNFUhAeEg0KCU1PREVSQVRPUhAoEgkKBUFETUlOEDI=');
@$core.Deprecated('Use activeDescriptor instead')
const Active$json = const {
  '1': 'Active',
  '2': const [
    const {'1': 'OFFLINE', '2': 0},
    const {'1': 'ONLINE', '2': 10},
    const {'1': 'TYPING', '2': 20},
  ],
};

/// Descriptor for `Active`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List activeDescriptor = $convert.base64Decode('CgZBY3RpdmUSCwoHT0ZGTElORRAAEgoKBk9OTElORRAKEgoKBlRZUElORxAU');
@$core.Deprecated('Use visibleDescriptor instead')
const Visible$json = const {
  '1': 'Visible',
  '2': const [
    const {'1': 'CLOSE', '2': 0},
    const {'1': 'MODERATED', '2': 10},
    const {'1': 'OPEN', '2': 20},
  ],
};

/// Descriptor for `Visible`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List visibleDescriptor = $convert.base64Decode('CgdWaXNpYmxlEgkKBUNMT1NFEAASDQoJTU9ERVJBVEVEEAoSCAoET1BFThAU');
@$core.Deprecated('Use mediaTypeDescriptor instead')
const MediaType$json = const {
  '1': 'MediaType',
  '2': const [
    const {'1': 'TEXT', '2': 0},
    const {'1': 'IMAGE', '2': 5},
    const {'1': 'VIDEO', '2': 10},
    const {'1': 'AUDIO', '2': 15},
    const {'1': 'PDF', '2': 20},
    const {'1': 'FILE', '2': 30},
    const {'1': 'QR', '2': 35},
  ],
};

/// Descriptor for `MediaType`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List mediaTypeDescriptor = $convert.base64Decode('CglNZWRpYVR5cGUSCAoEVEVYVBAAEgkKBUlNQUdFEAUSCQoFVklERU8QChIJCgVBVURJTxAPEgcKA1BERhAUEggKBEZJTEUQHhIGCgJRUhAj');
@$core.Deprecated('Use constDescriptor instead')
const Const$json = const {
  '1': 'Const',
  '2': const [
    const {'1': 'users', '2': 0},
    const {'1': 'rooms', '2': 10},
    const {'1': 'tweets', '2': 20},
    const {'1': 'id', '2': 100},
    const {'1': 'nam', '2': 150},
    const {'1': 'email', '2': 200},
    const {'1': 'phone', '2': 250},
    const {'1': 'avatar', '2': 350},
    const {'1': 'status', '2': 400},
    const {'1': 'created', '2': 600},
    const {'1': 'open', '2': 700},
    const {'1': 'members', '2': 800},
    const {'1': 'tweet_count', '2': 900},
    const {'1': 'description', '2': 1000},
  ],
};

/// Descriptor for `Const`. Decode as a `google.protobuf.EnumDescriptorProto`.
final $typed_data.Uint8List constDescriptor = $convert.base64Decode('CgVDb25zdBIJCgV1c2VycxAAEgkKBXJvb21zEAoSCgoGdHdlZXRzEBQSBgoCaWQQZBIICgNuYW0QlgESCgoFZW1haWwQyAESCgoFcGhvbmUQ+gESCwoGYXZhdGFyEN4CEgsKBnN0YXR1cxCQAxIMCgdjcmVhdGVkENgEEgkKBG9wZW4QvAUSDAoHbWVtYmVycxCgBhIQCgt0d2VldF9jb3VudBCEBxIQCgtkZXNjcmlwdGlvbhDoBw==');
@$core.Deprecated('Use userDescriptor instead')
const User$json = const {
  '1': 'User',
  '2': const [
    const {'1': 'id', '3': 100, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'nam', '3': 200, '4': 1, '5': 9, '10': 'nam'},
    const {'1': 'email', '3': 300, '4': 1, '5': 9, '10': 'email'},
    const {'1': 'phone', '3': 400, '4': 1, '5': 9, '10': 'phone'},
    const {'1': 'avatar', '3': 500, '4': 1, '5': 9, '10': 'avatar'},
    const {'1': 'status', '3': 600, '4': 1, '5': 14, '6': '.chat.Active', '10': 'status'},
    const {'1': 'rooms', '3': 700, '4': 3, '5': 9, '10': 'rooms'},
    const {'1': 'roomRequest', '3': 800, '4': 3, '5': 9, '10': 'roomRequest'},
    const {'1': 'created', '3': 900, '4': 1, '5': 9, '10': 'created'},
    const {'1': 'open', '3': 1000, '4': 1, '5': 14, '6': '.chat.Visible', '10': 'open'},
  ],
};

/// Descriptor for `User`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List userDescriptor = $convert.base64Decode('CgRVc2VyEg4KAmlkGGQgASgJUgJpZBIRCgNuYW0YyAEgASgJUgNuYW0SFQoFZW1haWwYrAIgASgJUgVlbWFpbBIVCgVwaG9uZRiQAyABKAlSBXBob25lEhcKBmF2YXRhchj0AyABKAlSBmF2YXRhchIlCgZzdGF0dXMY2AQgASgOMgwuY2hhdC5BY3RpdmVSBnN0YXR1cxIVCgVyb29tcxi8BSADKAlSBXJvb21zEiEKC3Jvb21SZXF1ZXN0GKAGIAMoCVILcm9vbVJlcXVlc3QSGQoHY3JlYXRlZBiEByABKAlSB2NyZWF0ZWQSIgoEb3BlbhjoByABKA4yDS5jaGF0LlZpc2libGVSBG9wZW4=');
@$core.Deprecated('Use roomUserDescriptor instead')
const RoomUser$json = const {
  '1': 'RoomUser',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'role', '3': 10, '4': 1, '5': 14, '6': '.chat.Role', '10': 'role'},
    const {'1': 'created', '3': 20, '4': 1, '5': 9, '10': 'created'},
  ],
};

/// Descriptor for `RoomUser`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomUserDescriptor = $convert.base64Decode('CghSb29tVXNlchIOCgJpZBgBIAEoCVICaWQSHgoEcm9sZRgKIAEoDjIKLmNoYXQuUm9sZVIEcm9sZRIYCgdjcmVhdGVkGBQgASgJUgdjcmVhdGVk');
@$core.Deprecated('Use roomDescriptor instead')
const Room$json = const {
  '1': 'Room',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'nam', '3': 10, '4': 1, '5': 9, '10': 'nam'},
    const {'1': 'avatar', '3': 20, '4': 1, '5': 9, '10': 'avatar'},
    const {'1': 'description', '3': 30, '4': 1, '5': 9, '10': 'description'},
    const {'1': 'members', '3': 40, '4': 3, '5': 11, '6': '.chat.RoomUser', '10': 'members'},
    const {'1': 'created', '3': 50, '4': 1, '5': 9, '10': 'created'},
    const {'1': 'open', '3': 60, '4': 1, '5': 14, '6': '.chat.Visible', '10': 'open'},
    const {'1': 'tweet_count', '3': 70, '4': 1, '5': 5, '10': 'tweetCount'},
  ],
};

/// Descriptor for `Room`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List roomDescriptor = $convert.base64Decode('CgRSb29tEg4KAmlkGAEgASgJUgJpZBIQCgNuYW0YCiABKAlSA25hbRIWCgZhdmF0YXIYFCABKAlSBmF2YXRhchIgCgtkZXNjcmlwdGlvbhgeIAEoCVILZGVzY3JpcHRpb24SKAoHbWVtYmVycxgoIAMoCzIOLmNoYXQuUm9vbVVzZXJSB21lbWJlcnMSGAoHY3JlYXRlZBgyIAEoCVIHY3JlYXRlZBIhCgRvcGVuGDwgASgOMg0uY2hhdC5WaXNpYmxlUgRvcGVuEh8KC3R3ZWV0X2NvdW50GEYgASgFUgp0d2VldENvdW50');
@$core.Deprecated('Use tweetDescriptor instead')
const Tweet$json = const {
  '1': 'Tweet',
  '2': const [
    const {'1': 'id', '3': 1, '4': 1, '5': 9, '10': 'id'},
    const {'1': 'sender_id', '3': 10, '4': 1, '5': 9, '10': 'senderId'},
    const {'1': 'room_id', '3': 20, '4': 1, '5': 9, '10': 'roomId'},
    const {'1': 'created', '3': 30, '4': 1, '5': 9, '10': 'created'},
    const {'1': 'media_type', '3': 40, '4': 1, '5': 14, '6': '.chat.MediaType', '10': 'mediaType'},
    const {'1': 'text', '3': 50, '4': 1, '5': 9, '10': 'text'},
    const {'1': 'link', '3': 60, '4': 1, '5': 9, '10': 'link'},
  ],
};

/// Descriptor for `Tweet`. Decode as a `google.protobuf.DescriptorProto`.
final $typed_data.Uint8List tweetDescriptor = $convert.base64Decode('CgVUd2VldBIOCgJpZBgBIAEoCVICaWQSGwoJc2VuZGVyX2lkGAogASgJUghzZW5kZXJJZBIXCgdyb29tX2lkGBQgASgJUgZyb29tSWQSGAoHY3JlYXRlZBgeIAEoCVIHY3JlYXRlZBIuCgptZWRpYV90eXBlGCggASgOMg8uY2hhdC5NZWRpYVR5cGVSCW1lZGlhVHlwZRISCgR0ZXh0GDIgASgJUgR0ZXh0EhIKBGxpbmsYPCABKAlSBGxpbms=');

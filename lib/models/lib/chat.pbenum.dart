///
//  Generated code. Do not modify.
//  source: lib/chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Role extends $pb.ProtobufEnum {
  static const Role BLOCKED = Role._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'BLOCKED');
  static const Role DENIED = Role._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'DENIED');
  static const Role REQUEST = Role._(20, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'REQUEST');
  static const Role USER = Role._(30, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'USER');
  static const Role MODERATOR = Role._(40, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MODERATOR');
  static const Role ADMIN = Role._(50, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ADMIN');

  static const $core.List<Role> values = <Role> [
    BLOCKED,
    DENIED,
    REQUEST,
    USER,
    MODERATOR,
    ADMIN,
  ];

  static final $core.Map<$core.int, Role> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Role? valueOf($core.int value) => _byValue[value];

  const Role._($core.int v, $core.String n) : super(v, n);
}

class Active extends $pb.ProtobufEnum {
  static const Active OFFLINE = Active._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OFFLINE');
  static const Active ONLINE = Active._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'ONLINE');
  static const Active TYPING = Active._(20, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TYPING');

  static const $core.List<Active> values = <Active> [
    OFFLINE,
    ONLINE,
    TYPING,
  ];

  static final $core.Map<$core.int, Active> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Active? valueOf($core.int value) => _byValue[value];

  const Active._($core.int v, $core.String n) : super(v, n);
}

class Visible extends $pb.ProtobufEnum {
  static const Visible CLOSE = Visible._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'CLOSE');
  static const Visible MODERATED = Visible._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'MODERATED');
  static const Visible OPEN = Visible._(20, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'OPEN');

  static const $core.List<Visible> values = <Visible> [
    CLOSE,
    MODERATED,
    OPEN,
  ];

  static final $core.Map<$core.int, Visible> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Visible? valueOf($core.int value) => _byValue[value];

  const Visible._($core.int v, $core.String n) : super(v, n);
}

class MediaType extends $pb.ProtobufEnum {
  static const MediaType TEXT = MediaType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'TEXT');
  static const MediaType IMAGE = MediaType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'IMAGE');
  static const MediaType VIDEO = MediaType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'VIDEO');
  static const MediaType AUDIO = MediaType._(15, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'AUDIO');
  static const MediaType PDF = MediaType._(20, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'PDF');
  static const MediaType FILE = MediaType._(30, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'FILE');
  static const MediaType QR = MediaType._(35, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'QR');

  static const $core.List<MediaType> values = <MediaType> [
    TEXT,
    IMAGE,
    VIDEO,
    AUDIO,
    PDF,
    FILE,
    QR,
  ];

  static final $core.Map<$core.int, MediaType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MediaType? valueOf($core.int value) => _byValue[value];

  const MediaType._($core.int v, $core.String n) : super(v, n);
}

class Const extends $pb.ProtobufEnum {
  static const Const users = Const._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'users');
  static const Const rooms = Const._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'rooms');
  static const Const tweets = Const._(20, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'tweets');
  static const Const id = Const._(100, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'id');
  static const Const nam = Const._(150, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'nam');
  static const Const email = Const._(200, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'email');
  static const Const phone = Const._(250, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'phone');
  static const Const avatar = Const._(350, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'avatar');
  static const Const status = Const._(400, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'status');
  static const Const created = Const._(600, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'created');
  static const Const open = Const._(700, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'open');
  static const Const members = Const._(800, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'members');
  static const Const tweet_count = Const._(900, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'tweet_count');
  static const Const description = Const._(1000, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'description');

  static const $core.List<Const> values = <Const> [
    users,
    rooms,
    tweets,
    id,
    nam,
    email,
    phone,
    avatar,
    status,
    created,
    open,
    members,
    tweet_count,
    description,
  ];

  static final $core.Map<$core.int, Const> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Const? valueOf($core.int value) => _byValue[value];

  const Const._($core.int v, $core.String n) : super(v, n);
}


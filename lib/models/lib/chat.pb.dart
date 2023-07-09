///
//  Generated code. Do not modify.
//  source: lib/chat.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,constant_identifier_names,directives_ordering,library_prefixes,non_constant_identifier_names,prefer_final_fields,return_of_invalid_type,unnecessary_const,unnecessary_import,unnecessary_this,unused_import,unused_shown_name

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'chat.pbenum.dart';

export 'chat.pbenum.dart';

class User extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'User', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chat'), createEmptyInstance: create)
    ..aOS(100, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(200, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nam')
    ..aOS(300, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'email')
    ..aOS(400, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'phone')
    ..aOS(500, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'avatar')
    ..e<Active>(600, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'status', $pb.PbFieldType.OE, defaultOrMaker: Active.OFFLINE, valueOf: Active.valueOf, enumValues: Active.values)
    ..pPS(700, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rooms')
    ..pPS(800, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'roomRequest', protoName: 'roomRequest')
    ..aOS(900, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'created')
    ..e<Visible>(1000, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'open', $pb.PbFieldType.OE, defaultOrMaker: Visible.CLOSE, valueOf: Visible.valueOf, enumValues: Visible.values)
    ..hasRequiredFields = false
  ;

  User._() : super();
  factory User({
    $core.String? id,
    $core.String? nam,
    $core.String? email,
    $core.String? phone,
    $core.String? avatar,
    Active? status,
    $core.Iterable<$core.String>? rooms,
    $core.Iterable<$core.String>? roomRequest,
    $core.String? created,
    Visible? open,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (nam != null) {
      _result.nam = nam;
    }
    if (email != null) {
      _result.email = email;
    }
    if (phone != null) {
      _result.phone = phone;
    }
    if (avatar != null) {
      _result.avatar = avatar;
    }
    if (status != null) {
      _result.status = status;
    }
    if (rooms != null) {
      _result.rooms.addAll(rooms);
    }
    if (roomRequest != null) {
      _result.roomRequest.addAll(roomRequest);
    }
    if (created != null) {
      _result.created = created;
    }
    if (open != null) {
      _result.open = open;
    }
    return _result;
  }
  factory User.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory User.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  User clone() => User()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  User copyWith(void Function(User) updates) => super.copyWith((message) => updates(message as User)) as User; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static User create() => User._();
  User createEmptyInstance() => create();
  static $pb.PbList<User> createRepeated() => $pb.PbList<User>();
  @$core.pragma('dart2js:noInline')
  static User getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<User>(create);
  static User? _defaultInstance;

  @$pb.TagNumber(100)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(100)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(100)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(100)
  void clearId() => clearField(100);

  @$pb.TagNumber(200)
  $core.String get nam => $_getSZ(1);
  @$pb.TagNumber(200)
  set nam($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(200)
  $core.bool hasNam() => $_has(1);
  @$pb.TagNumber(200)
  void clearNam() => clearField(200);

  @$pb.TagNumber(300)
  $core.String get email => $_getSZ(2);
  @$pb.TagNumber(300)
  set email($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(300)
  $core.bool hasEmail() => $_has(2);
  @$pb.TagNumber(300)
  void clearEmail() => clearField(300);

  @$pb.TagNumber(400)
  $core.String get phone => $_getSZ(3);
  @$pb.TagNumber(400)
  set phone($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(400)
  $core.bool hasPhone() => $_has(3);
  @$pb.TagNumber(400)
  void clearPhone() => clearField(400);

  @$pb.TagNumber(500)
  $core.String get avatar => $_getSZ(4);
  @$pb.TagNumber(500)
  set avatar($core.String v) { $_setString(4, v); }
  @$pb.TagNumber(500)
  $core.bool hasAvatar() => $_has(4);
  @$pb.TagNumber(500)
  void clearAvatar() => clearField(500);

  @$pb.TagNumber(600)
  Active get status => $_getN(5);
  @$pb.TagNumber(600)
  set status(Active v) { setField(600, v); }
  @$pb.TagNumber(600)
  $core.bool hasStatus() => $_has(5);
  @$pb.TagNumber(600)
  void clearStatus() => clearField(600);

  @$pb.TagNumber(700)
  $core.List<$core.String> get rooms => $_getList(6);

  @$pb.TagNumber(800)
  $core.List<$core.String> get roomRequest => $_getList(7);

  @$pb.TagNumber(900)
  $core.String get created => $_getSZ(8);
  @$pb.TagNumber(900)
  set created($core.String v) { $_setString(8, v); }
  @$pb.TagNumber(900)
  $core.bool hasCreated() => $_has(8);
  @$pb.TagNumber(900)
  void clearCreated() => clearField(900);

  @$pb.TagNumber(1000)
  Visible get open => $_getN(9);
  @$pb.TagNumber(1000)
  set open(Visible v) { setField(1000, v); }
  @$pb.TagNumber(1000)
  $core.bool hasOpen() => $_has(9);
  @$pb.TagNumber(1000)
  void clearOpen() => clearField(1000);
}

class RoomUser extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'RoomUser', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chat'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..e<Role>(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'role', $pb.PbFieldType.OE, defaultOrMaker: Role.BLOCKED, valueOf: Role.valueOf, enumValues: Role.values)
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'created')
    ..hasRequiredFields = false
  ;

  RoomUser._() : super();
  factory RoomUser({
    $core.String? id,
    Role? role,
    $core.String? created,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (role != null) {
      _result.role = role;
    }
    if (created != null) {
      _result.created = created;
    }
    return _result;
  }
  factory RoomUser.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory RoomUser.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  RoomUser clone() => RoomUser()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  RoomUser copyWith(void Function(RoomUser) updates) => super.copyWith((message) => updates(message as RoomUser)) as RoomUser; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static RoomUser create() => RoomUser._();
  RoomUser createEmptyInstance() => create();
  static $pb.PbList<RoomUser> createRepeated() => $pb.PbList<RoomUser>();
  @$core.pragma('dart2js:noInline')
  static RoomUser getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<RoomUser>(create);
  static RoomUser? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(10)
  Role get role => $_getN(1);
  @$pb.TagNumber(10)
  set role(Role v) { setField(10, v); }
  @$pb.TagNumber(10)
  $core.bool hasRole() => $_has(1);
  @$pb.TagNumber(10)
  void clearRole() => clearField(10);

  @$pb.TagNumber(20)
  $core.String get created => $_getSZ(2);
  @$pb.TagNumber(20)
  set created($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(20)
  $core.bool hasCreated() => $_has(2);
  @$pb.TagNumber(20)
  void clearCreated() => clearField(20);
}

class Room extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Room', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chat'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'nam')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'avatar')
    ..aOS(30, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'description')
    ..pc<RoomUser>(40, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'members', $pb.PbFieldType.PM, subBuilder: RoomUser.create)
    ..aOS(50, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'created')
    ..e<Visible>(60, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'open', $pb.PbFieldType.OE, defaultOrMaker: Visible.CLOSE, valueOf: Visible.valueOf, enumValues: Visible.values)
    ..a<$core.int>(70, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tweetCount', $pb.PbFieldType.O3)
    ..hasRequiredFields = false
  ;

  Room._() : super();
  factory Room({
    $core.String? id,
    $core.String? nam,
    $core.String? avatar,
    $core.String? description,
    $core.Iterable<RoomUser>? members,
    $core.String? created,
    Visible? open,
    $core.int? tweetCount,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (nam != null) {
      _result.nam = nam;
    }
    if (avatar != null) {
      _result.avatar = avatar;
    }
    if (description != null) {
      _result.description = description;
    }
    if (members != null) {
      _result.members.addAll(members);
    }
    if (created != null) {
      _result.created = created;
    }
    if (open != null) {
      _result.open = open;
    }
    if (tweetCount != null) {
      _result.tweetCount = tweetCount;
    }
    return _result;
  }
  factory Room.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Room.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Room clone() => Room()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Room copyWith(void Function(Room) updates) => super.copyWith((message) => updates(message as Room)) as Room; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Room create() => Room._();
  Room createEmptyInstance() => create();
  static $pb.PbList<Room> createRepeated() => $pb.PbList<Room>();
  @$core.pragma('dart2js:noInline')
  static Room getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Room>(create);
  static Room? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(10)
  $core.String get nam => $_getSZ(1);
  @$pb.TagNumber(10)
  set nam($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(10)
  $core.bool hasNam() => $_has(1);
  @$pb.TagNumber(10)
  void clearNam() => clearField(10);

  @$pb.TagNumber(20)
  $core.String get avatar => $_getSZ(2);
  @$pb.TagNumber(20)
  set avatar($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(20)
  $core.bool hasAvatar() => $_has(2);
  @$pb.TagNumber(20)
  void clearAvatar() => clearField(20);

  @$pb.TagNumber(30)
  $core.String get description => $_getSZ(3);
  @$pb.TagNumber(30)
  set description($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(30)
  $core.bool hasDescription() => $_has(3);
  @$pb.TagNumber(30)
  void clearDescription() => clearField(30);

  @$pb.TagNumber(40)
  $core.List<RoomUser> get members => $_getList(4);

  @$pb.TagNumber(50)
  $core.String get created => $_getSZ(5);
  @$pb.TagNumber(50)
  set created($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(50)
  $core.bool hasCreated() => $_has(5);
  @$pb.TagNumber(50)
  void clearCreated() => clearField(50);

  @$pb.TagNumber(60)
  Visible get open => $_getN(6);
  @$pb.TagNumber(60)
  set open(Visible v) { setField(60, v); }
  @$pb.TagNumber(60)
  $core.bool hasOpen() => $_has(6);
  @$pb.TagNumber(60)
  void clearOpen() => clearField(60);

  @$pb.TagNumber(70)
  $core.int get tweetCount => $_getIZ(7);
  @$pb.TagNumber(70)
  set tweetCount($core.int v) { $_setSignedInt32(7, v); }
  @$pb.TagNumber(70)
  $core.bool hasTweetCount() => $_has(7);
  @$pb.TagNumber(70)
  void clearTweetCount() => clearField(70);
}

class Tweet extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tweet', package: const $pb.PackageName(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'chat'), createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(10, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'senderId')
    ..aOS(20, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'roomId')
    ..aOS(30, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'created')
    ..e<MediaType>(40, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'mediaType', $pb.PbFieldType.OE, defaultOrMaker: MediaType.TEXT, valueOf: MediaType.valueOf, enumValues: MediaType.values)
    ..aOS(50, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'text')
    ..aOS(60, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'link')
    ..hasRequiredFields = false
  ;

  Tweet._() : super();
  factory Tweet({
    $core.String? id,
    $core.String? senderId,
    $core.String? roomId,
    $core.String? created,
    MediaType? mediaType,
    $core.String? text,
    $core.String? link,
  }) {
    final _result = create();
    if (id != null) {
      _result.id = id;
    }
    if (senderId != null) {
      _result.senderId = senderId;
    }
    if (roomId != null) {
      _result.roomId = roomId;
    }
    if (created != null) {
      _result.created = created;
    }
    if (mediaType != null) {
      _result.mediaType = mediaType;
    }
    if (text != null) {
      _result.text = text;
    }
    if (link != null) {
      _result.link = link;
    }
    return _result;
  }
  factory Tweet.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tweet.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tweet clone() => Tweet()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tweet copyWith(void Function(Tweet) updates) => super.copyWith((message) => updates(message as Tweet)) as Tweet; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tweet create() => Tweet._();
  Tweet createEmptyInstance() => create();
  static $pb.PbList<Tweet> createRepeated() => $pb.PbList<Tweet>();
  @$core.pragma('dart2js:noInline')
  static Tweet getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tweet>(create);
  static Tweet? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(10)
  $core.String get senderId => $_getSZ(1);
  @$pb.TagNumber(10)
  set senderId($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(10)
  $core.bool hasSenderId() => $_has(1);
  @$pb.TagNumber(10)
  void clearSenderId() => clearField(10);

  @$pb.TagNumber(20)
  $core.String get roomId => $_getSZ(2);
  @$pb.TagNumber(20)
  set roomId($core.String v) { $_setString(2, v); }
  @$pb.TagNumber(20)
  $core.bool hasRoomId() => $_has(2);
  @$pb.TagNumber(20)
  void clearRoomId() => clearField(20);

  @$pb.TagNumber(30)
  $core.String get created => $_getSZ(3);
  @$pb.TagNumber(30)
  set created($core.String v) { $_setString(3, v); }
  @$pb.TagNumber(30)
  $core.bool hasCreated() => $_has(3);
  @$pb.TagNumber(30)
  void clearCreated() => clearField(30);

  @$pb.TagNumber(40)
  MediaType get mediaType => $_getN(4);
  @$pb.TagNumber(40)
  set mediaType(MediaType v) { setField(40, v); }
  @$pb.TagNumber(40)
  $core.bool hasMediaType() => $_has(4);
  @$pb.TagNumber(40)
  void clearMediaType() => clearField(40);

  @$pb.TagNumber(50)
  $core.String get text => $_getSZ(5);
  @$pb.TagNumber(50)
  set text($core.String v) { $_setString(5, v); }
  @$pb.TagNumber(50)
  $core.bool hasText() => $_has(5);
  @$pb.TagNumber(50)
  void clearText() => clearField(50);

  @$pb.TagNumber(60)
  $core.String get link => $_getSZ(6);
  @$pb.TagNumber(60)
  set link($core.String v) { $_setString(6, v); }
  @$pb.TagNumber(60)
  $core.bool hasLink() => $_has(6);
  @$pb.TagNumber(60)
  void clearLink() => clearField(60);
}


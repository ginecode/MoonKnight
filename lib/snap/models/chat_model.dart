// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'dart:collection';
// import 'dart:convert';

// import 'package:moonknight/models/lib/chat.pb.dart';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/foundation.dart' show immutable;

//--------------------------------------------------------------------

// TODO : Convert everything into transaction

// @short_user_name
// + Add Users to user collection (Unique) : When new user is created trigger cloud function to add it to users collection
// - Search Users with id
// - Update User Profile
// Follow user, unfollow user

// #short_room_name
// + Create Rooms : Room can have 2 or more people
// + If you are admin create promote to admin
// + If you are admin, can kick users but not admins
// + Show option to leave room. If multiple admins, after all admins are gone last admin can delete the room, show option to delete room. If last admin leaves the room then promote oldest member to admin.
// Invite member to room
// + Search rooms with room id
// Display number of new messages in room
// join open room, send request to join closed room

// tweet subcollection
// send tweets in room
// delete tweet if it is yours or you are admin and tweet is not from admin
// edit your own message
// reaction message

//----------------

// Display number of new messages in friend, number of comments, number of likes, engagment time series

// Show popular, show friends messages first
// Message Engagment : 1 point for post, 1 point for #retweet, .6 for retweet, .4 comment, .2 like

// Add Friends, Friendship strength
// Block users

// Push notification
// End to end encryption
// Reaction on Messages
// Messages without room are posts available in feed
// Share messages
//--------------------------------------------------------------------

// @immutable
// class Room extends MapView<String, dynamic> {
//   static const String collectionName = 'rooms';
//   static const String roomIdField = 'roomId';
//   static const String nameField = 'name';
//   static const String avatarUrlField = 'avatarUrl';
//   static const String descriptionField = 'description';
//   static const String membersField = 'members';
//   static const String createdAtField = 'createdAt';
//   static const String updatedAtField = 'updatedAt';
//   static const String openField = 'open';

//   final String roomId;
//   final String name;
//   final String? avatarUrl;
//   final String? description;
//   final List<String> members;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final bool open;

//   Room({
//     required this.roomId,
//     required this.name,
//     this.avatarUrl,
//     this.description,
//     this.members = const [],
//     this.createdAt,
//     this.updatedAt,
//     this.open = false,
//   }) : super({
//           roomIdField: roomId,
//           nameField: name,
//           avatarUrlField: avatarUrl,
//           descriptionField: description,
//           membersField: members,
//           createdAtField: createdAt?.millisecondsSinceEpoch,
//           updatedAtField: updatedAt?.millisecondsSinceEpoch,
//           openField: open,
//         });

//   String toJson() => json.encode(this);

//   static Room? fromMap(Map<String, dynamic> map) {
//     try {
//       return Room(
//         roomId: map[roomIdField],
//         name: map[nameField],
//         avatarUrl: map[avatarUrlField],
//         description: map[descriptionField],
//         members: List<String>.from(map[membersField] ?? []),
//         createdAt: map[createdAtField] != null ? DateTime.fromMillisecondsSinceEpoch(map[createdAtField]) : null,
//         updatedAt: map[updatedAtField] != null ? DateTime.fromMillisecondsSinceEpoch(map[updatedAtField]) : null,
//         open: map[openField],
//       );
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }

//   @override
//   String toString() {
//     return 'Room{roomId: $roomId, name: $name, description: $description, '
//         'members: $members, createdAt: $createdAt, updatedAt: $updatedAt, open: $open}';
//   }
// }

// enum Status {
//   online,
//   offline;

//   static Status fromString(String v) {
//     return values.where((m) => m.name == v).first;
//   }
// }

// extension UserX on User {
//   static String get collectionName => 'users';
//   static String get idField => 'id';
//   static const String nameField = 'name';
//   static const String emailField = 'email';
//   static const String tokenField = 'token';
//   static const String avatarUrlField = 'avatarUrl';
//   static const String statusField = 'status';
//   static const String roomsField = 'rooms';
//   static const String levelField = 'level';
//   static const String createdAtField = 'createdAt';
//   static const String updatedAtField = 'updatedAt';
//   static const String openField = 'open';
// }

// @immutable
// class User {
//   static const String collectionName = 'users';
//   static const String idField = 'id';
//   static const String nameField = 'name';
//   static const String emailField = 'email';
//   static const String tokenField = 'token';
//   static const String avatarUrlField = 'avatarUrl';
//   static const String statusField = 'status';
//   static const String roomsField = 'rooms';
//   static const String levelField = 'level';
//   static const String createdAtField = 'createdAt';
//   static const String updatedAtField = 'updatedAt';
//   static const String openField = 'open';

//   final String id;
//   final String name;
//   final String email;
//   final String? token;
//   final String? avatarUrl;
//   final Status? status;
//   final List<String> rooms;
//   final int level;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;
//   final bool open;

//   const User({
//     required this.id,
//     required this.name,
//     required this.email,
//     this.token,
//     this.avatarUrl,
//     this.status,
//     this.rooms = const [],
//     this.level = 0,
//     this.createdAt,
//     this.updatedAt,
//     this.open = false,
//   });

//   Map<String, dynamic> toMap({bool usercol = false}) {
//     return {
//       idField: id,
//       nameField: name,
//       emailField: email,
//       if (!usercol) tokenField: token,
//       avatarUrlField: avatarUrl,
//       statusField: status,
//       roomsField: rooms,
//       levelField: level,
//       createdAtField: createdAt?.millisecondsSinceEpoch,
//       updatedAtField: updatedAt?.millisecondsSinceEpoch,
//       openField: open,
//     };
//   }

//   String toJson() => json.encode(toMap());

//   static User? fromMap(Map<String, dynamic> map) {
//     try {
//       return User(
//         id: map[idField],
//         name: map[nameField],
//         email: map[emailField],
//         token: map[tokenField],
//         avatarUrl: map[avatarUrlField],
//         status: Status.fromString(map[statusField] ?? Status.offline.name),
//         rooms: List<String>.from(map[roomsField] ?? []),
//         level: map[levelField] ?? 0,
//         createdAt: map[createdAtField] != null ? DateTime.fromMillisecondsSinceEpoch(map[createdAtField]) : null,
//         updatedAt: map[updatedAtField] != null ? DateTime.fromMillisecondsSinceEpoch(map[updatedAtField]) : null,
//         open: map[openField] ?? false,
//       );
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }

//   @override
//   String toString() {
//     return toMap().toString();
//   }
// }

// enum MediaType {
//   image,
//   video,
//   link;

//   static MediaType fromString(String v) {
//     return values.where((m) => m.name == v).first;
//   }
// }

// @immutable
// class Media {
//   static const String urlField = 'url';
//   static const String thumbnailField = 'thumbnail';
//   static const String mediaTypeField = 'mediaType';

//   final String url;
//   final String? thumbnail;
//   final MediaType type;

//   const Media({
//     required this.url,
//     this.thumbnail,
//     required this.type,
//   });

//   Map<String, dynamic> toMap() {
//     return <String, dynamic>{
//       urlField: url,
//       thumbnailField: thumbnail,
//       mediaTypeField: type,
//     };
//   }

//   factory Media.fromMap(Map<String, dynamic> map) {
//     return Media(
//       url: map[urlField] as String,
//       thumbnail: map[thumbnailField] as String,
//       type: MediaType.fromString(map[mediaTypeField]),
//     );
//   }

//   String toJson() => json.encode(toMap());

//   factory Media.fromJson(String source) => Media.fromMap(json.decode(source) as Map<String, dynamic>);

//   @override
//   String toString() => 'Media{url: $url, thumbnail: $thumbnail, type: $type}';
// }

// @immutable
// class Message {
//   static const String collectionName = 'messages';
//   static const String messageIdField = 'messageId';
//   static const String roomIdField = 'roomId';
//   static const String senderIdField = 'senderId';
//   static const String textField = 'text';
//   static const String createdAtField = 'createdAt';

//   static const String likesField = 'likes';
//   static const String commentsField = 'comments';
//   static const String retweetsField = 'retweets';
//   static const String mediaField = 'media';

//   final String messageId;
//   final String roomId;
//   final String senderId;
//   final String text;
//   final DateTime? createdAt;

//   final int? comments;
//   final int? likes;
//   final int? retweets;
//   final Media? media;

//   const Message({
//     required this.messageId,
//     required this.roomId,
//     required this.senderId,
//     required this.text,
//     this.createdAt,
//     this.comments = 0,
//     this.likes = 0,
//     this.retweets = 0,
//     this.media,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       messageIdField: messageId,
//       roomIdField: roomId,
//       senderIdField: senderId,
//       textField: text,
//       createdAtField: createdAt?.millisecondsSinceEpoch,
//       commentsField: comments,
//       likesField: likes,
//       retweetsField: retweets,
//       mediaField: media,
//     };
//   }

//   String toJson() => json.encode(toMap());

//   static Message? fromMap(Map<String, dynamic> map) {
//     try {
//       return Message(
//         messageId: map[messageIdField],
//         roomId: map[roomIdField],
//         senderId: map[senderIdField],
//         text: map[textField],
//         createdAt: map[createdAtField] != null ? DateTime.fromMillisecondsSinceEpoch(map[createdAtField]) : null,
//         comments: map[commentsField],
//         likes: map[likesField],
//         retweets: map[retweetsField],
//         media: Media.fromMap(map[mediaField]),
//       );
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }

//   @override
//   String toString() {
//     return 'Message{messageId: $messageId, roomId: $roomId, '
//         'senderId: $senderId, text: $text, createdAt: $createdAt, '
//         'likes: $likes, comments: $comments, retweets: $retweets}';
//   }
// }

// @immutable
// class Like extends MapView<String, dynamic> {
//   static const String collectionName = 'likes';
//   static const String messageIdField = 'messageId';
//   static const String userIdField = 'userId';
//   static const String createdAtField = 'createdAt';

//   // String id;
//   final String postId;
//   final String userId;
//   final DateTime? createdAt;

//   Like({
//     // required this.id,
//     required this.postId,
//     required this.userId,
//     this.createdAt,
//   }) : super({
//           // if (id != null) 'id': id,
//           messageIdField: postId,
//           userIdField: userId,
//           createdAtField: createdAt != null ? Timestamp.fromDate(createdAt) : null,
//         });

//   factory Like.fromMap(Map<String, dynamic> map) {
//     return Like(
//       // id: map['id'],
//       postId: map[messageIdField],
//       userId: map[userIdField],
//       createdAt: (map[createdAtField] as Timestamp).toDate(),
//     );
//   }

//   String toJson() => json.encode(this);

//   factory Like.fromJson(String source) => Like.fromMap(json.decode(source));

//   @override
//   String toString() => 'Like$this';
// }

// @immutable
// class Friend {
//   static const String collectionName = 'friends';
//   static const String userIdField = 'userId';
//   static const String friendIdField = 'friendId';
//   static const String createdAtField = 'createdAt';

//   final String userId;
//   final String friendId;
//   final DateTime? createdAt;

//   const Friend({
//     required this.userId,
//     required this.friendId,
//     this.createdAt,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       userIdField: userId,
//       friendIdField: friendId,
//       createdAtField: createdAt?.millisecondsSinceEpoch,
//     };
//   }

//   String toJson() => json.encode(toMap());

//   static Friend? fromMap(Map<String, dynamic> map) {
//     try {
//       return Friend(
//         userId: map[userIdField],
//         friendId: map[friendIdField],
//         createdAt: map[createdAtField] != null ? DateTime.fromMillisecondsSinceEpoch(map[createdAtField]) : null,
//       );
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }

//   @override
//   String toString() {
//     return 'Friend{userId: $userId, friendId: $friendId, '
//         'createdAt: $createdAt}';
//   }
// }

// @immutable
// class Blocked {
//   static const String collectionName = 'blocked';
//   static const String userIdField = 'userId';
//   static const String blockedIdField = 'blockedId';
//   static const String createdAtField = 'createdAt';

//   final String userId;
//   final String blockedId;
//   final DateTime? createdAt;

//   const Blocked({
//     required this.userId,
//     required this.blockedId,
//     this.createdAt,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       userIdField: userId,
//       blockedIdField: blockedId,
//       createdAtField: createdAt?.millisecondsSinceEpoch,
//     };
//   }

//   String toJson() => json.encode(toMap());

//   static Blocked? fromMap(Map<String, dynamic> map) {
//     try {
//       return Blocked(
//         userId: map[userIdField],
//         blockedId: map[blockedIdField],
//         createdAt: map[createdAtField] != null ? DateTime.fromMillisecondsSinceEpoch(map[createdAtField]) : null,
//       );
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }

//   @override
//   String toString() {
//     return 'Blocked{userId: $userId, blockedId: $blockedId, '
//         'createdAt: $createdAt}';
//   }
// }

// @immutable
// class Settings extends MapView<String, dynamic> {
//   static const String collectionName = 'settings';
//   static const String userIdField = 'userId';
//   static const String notificationsEnabledField = 'notificationsEnabled';
//   static const String createdAtField = 'createdAt';
//   static const String updatedAtField = 'updatedAt';

//   final String userId;
//   final bool notificationsEnabled;
//   final DateTime? createdAt;
//   final DateTime? updatedAt;

//   Settings({
//     required this.userId,
//     this.notificationsEnabled = true,
//     this.createdAt,
//     this.updatedAt,
//   }) : super({
//           userIdField: userId,
//           notificationsEnabledField: notificationsEnabled,
//           createdAtField: createdAt?.millisecondsSinceEpoch,
//           updatedAtField: updatedAt?.millisecondsSinceEpoch,
//         });

//   String toJson() => json.encode(this);

//   static Settings? fromMap(Map<String, dynamic> map) {
//     try {
//       return Settings(
//         userId: map[userIdField],
//         notificationsEnabled: map[notificationsEnabledField],
//         createdAt: map[createdAtField] != null ? DateTime.fromMillisecondsSinceEpoch(map[createdAtField]) : null,
//         updatedAt: map[updatedAtField] != null ? DateTime.fromMillisecondsSinceEpoch(map[updatedAtField]) : null,
//       );
//     } catch (e) {
//       print(e);
//     }
//     return null;
//   }

//   @override
//   String toString() {
//     return 'Settings{userId: $userId, notificationsEnabled: $notificationsEnabled, '
//         'createdAt: $createdAt, updatedAt: $updatedAt}';
//   }
// }

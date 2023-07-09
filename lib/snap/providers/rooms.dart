import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:moonknight/models/lib/chat.pb.dart';
import 'package:moonknight/snap/proto_help/utils.dart';
import 'package:tamannaah/darkknight/debug_functions.dart';

import 'package:tamannaah/darkknight/extensions/extensions.dart';

import 'auth.dart';

part 'rooms.g.dart';

@riverpod
class RoomText extends _$RoomText {
  @override
  Future<String?> build() async {
    return null;
  }

  void change(String roomId) async {
    state = await AsyncValue.guard(() async {
      await 1.sec.delay();
      return roomId;
    });
  }
}

@riverpod
Future<Room?> getRoom(GetRoomRef ref) async {
  final roomId = ref.watch(roomTextProvider).value;
  if (roomId == null || roomId == '') return null;

  Room? room = await FirebaseFirestore.instance
      .collection(
        Const.rooms.name,
      )
      .doc(roomId)
      .get()
      .then(
        (value) => fromDocSnap(Room(), value),
      );
  return room;
}

@riverpod
Future<List<Room?>> getAllRooms(GetAllRoomsRef ref) async {
  List<Room?> rooms = await FirebaseFirestore.instance
      .collection(Const.rooms.name)
      // .where(Room.roomIdField, isEqualTo: user?.id)
      .get()
      .then(
        (value) => value.docs.map(
          (e) {
            unicorn(e.toString());
            return fromQuerySnap(Room(), e);
          },
        ).toList(),
      );

  return rooms;
}

extension SuperRoom on Room {
  DocumentReference<Room?> get roomDoc {
    return FirebaseFirestore.instance.collection(Const.rooms.name).doc(id).withConverter(
      fromFirestore: (snapshot, options) {
        return fromDocSnap(Room(), snapshot);
      },
      toFirestore: (value, options) {
        return value?.toMap() ?? {};
      },
    );
  }

  CollectionReference<Tweet?>? get tweetCol {
    return FirebaseFirestore.instance.collection('${Const.rooms.name}/$id/${Const.tweets.name}').withConverter(
      fromFirestore: (snapshot, options) {
        return fromDocSnap(Tweet(), snapshot);
      },
      toFirestore: (value, options) {
        return value?.toMap() ?? {};
      },
    );
  }
}

@riverpod
Stream<Room?> roomStream(RoomStreamRef ref) {
  //TODO : ref.state;
  //TODO : remove hello != null
  //TODO : ref.state != hello
  //TODO : replace ref.read(currentRoomProvider) with hello

  final hello = ref.watch(currentRoomProvider).value?.roomDoc;
  if (hello != null) {
    unicorn('Stream Working');
    return hello.snapshots().map((event) {
      unicorn('----*************----');
      unicorn(event.toString());
      if (ref.read(currentRoomProvider).value != event.data()) {
        ref.read(currentRoomProvider.notifier).updateRoom(room: event.data());
      }
      unicorn('----*************----');
      return event.data();
    });
  } else {
    unicorn('Stream Not Working');
    return const Stream.empty();
  }
}

@riverpod
class CurrentRoom extends _$CurrentRoom {
  @override
  Future<Room?> build() async {
    return null;
  }

  void updateRoom({Room? room, String? id}) async {
    if (room != null && room != state.value) {
      state = AsyncValue.data(room);
    } else if (id != null && id != state.value?.id) {
      final room = await FirebaseFirestore.instance.collection(Const.rooms.name).doc(id).get();
      state = AsyncValue.data(fromDocSnap(Room(), room));
    }
    // else if (state.value != null) {
    //   final room = await FirebaseFirestore.instance.collection(Const.rooms.name).doc(state.value!.id).get();
    //   state = AsyncValue.data(fromDocSnap(Room(), room));
    // }
  }

  void exitRoom() {
    lava('Room Exited');
    state = const AsyncValue.data(null);
  }

  Future<Room?> createRoom({
    required String roomName,

    //
    String? avatar,
    String? description,
    Visible open = Visible.CLOSE,

    //
    required List<User> users,
  }) async {
    final currentUser = ref.read(currentUserProvider).value!;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      users.removeWhere((element) => element.id == currentUser.id);
      if (users.isEmpty) return null;

      // Creates the room, with all given members including you.
      final room = await FirebaseFirestore.instance
          .collection(Const.rooms.name)
          .add(
            Room(
              nam: roomName,

              //
              avatar: avatar,
              description: description,
              open: open,
              created: DateTime.now().toIso8601String(),

              //
              members: [
                //
                RoomUser(
                  id: currentUser.id,
                  role: Role.ADMIN,
                  created: DateTime.now().toIso8601String(),
                ),

                //
                ...users.map(
                  (e) => RoomUser(
                    id: e.id,
                    role: Role.USER,
                    created: DateTime.now().toIso8601String(),
                  ),
                ),
              ],
            ).toMap()!,
          )
          .then(
        (value) async {
          return fromDocSnap(Room(), (await value.get()));
        },
      );

      //Add room id to all members
      for (User u in [currentUser, ...users]) {
        await addRoomIdToUser(userId: u.id, roomId: room!.id, add: true);
      }
      return room;
    });
    return state.value;
  }

  Future<void> addRoomIdToUser({required String userId, required String roomId, required bool add}) async {
    await FirebaseFirestore.instance.collection(Const.users.name).doc(userId).update(
      {
        if (add) Const.rooms.name: FieldValue.arrayUnion([roomId]),
        if (!add) Const.rooms.name: FieldValue.arrayRemove([roomId]),
      },
    );
  }

  void acceptMemberToRoom(RoomUser newUser) async {
    final currentUser = ref.read(currentUserProvider).value!;
    final currentRoom = state.value;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      //Check room
      if (currentRoom?.id == null || currentRoom?.id == '') throw (Exception('No Room'));

      //Check admin || Moderator
      final myRole = currentRoom?.members.where((u) => u.id == currentUser.id).first.role;
      if (!(myRole == Role.ADMIN || myRole == Role.MODERATOR)) {
        throw (Exception('User not admin'));
      }

      _changeRole(
        currentRoom!,
        newUser,
        Role.USER,
      );

      return currentRoom;
    });
  }

  void requestMemberToRoom(List<String> newUsers) async {
    // final currentUser = ref.read(currentUserProvider).value!;
    final currentRoom = state.value;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      //Check room
      if (currentRoom?.id == null || currentRoom?.id == '') throw (Exception('No Room'));

      // //Check admin
      // if (currentRoom?.members.where((u) => u.id == currentUser.id).first.role != Role.ADMIN) {
      //   throw (Exception('User not admin'));
      // }

      // Add newUser to rooms member list
      await FirebaseFirestore.instance.collection(Const.rooms.name).doc(currentRoom?.id).update({
        Const.members.name: FieldValue.arrayUnion(
          newUsers
              .map((e) => RoomUser(
                    id: e,
                    role: Role.REQUEST,
                    created: DateTime.now().toIso8601String(),
                  ).toMap()!)
              .toList(),
        )
      });

      // Add room to newUser rooms list

      Future.wait(
        newUsers.map(
          (e) async => await addRoomIdToUser(
            userId: e,
            roomId: currentRoom!.id,
            add: true,
          ),
        ),
      );

      return currentRoom;
    });
  }

  Future<void> _changeRole(Room room, RoomUser user, Role role) async {
    final currentUser = ref.read(currentUserProvider).value!;

    final admin = room.members.where((u) => u.id == currentUser.id).first;

    //Check admin
    if (admin.role != Role.ADMIN) throw (Exception('User not admin'));

    if (admin.role.value < user.role.value) throw (Exception('Not enough priviledge'));

    await FirebaseFirestore.instance.collection(Const.rooms.name).doc(room.id).update({
      Const.members.name: FieldValue.arrayRemove(
        [
          user.toMap(),
        ],
      )
    });

    await FirebaseFirestore.instance.collection(Const.rooms.name).doc(room.id).update({
      Const.members.name: FieldValue.arrayUnion(
        [
          RoomUser(
            id: user.id,
            role: role,
            created: DateTime.now().toIso8601String(),
          ).toMap(),
        ],
      )
    });
  }

  void changeRole(RoomUser user, Role role) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final room = state.value!;
      await _changeRole(room, user, role);
      return room;
    });
  }

  void leaveRoom() async {
    final currentUser = ref.read(currentUserProvider).value!;
    final currentRoom = state.value;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      //Check room
      if (currentRoom?.id == null || currentRoom?.id == '') throw (Exception('No Room'));

      final userInRoom = currentRoom!.members.where((u) => u.id == currentUser.id).first;

      final numAdmin = currentRoom.members
          .where(
            (element) => element.role == Role.ADMIN,
          )
          .length;

      // If i am the only admin then promote oldest user to admin
      if (numAdmin == 1) {
        currentRoom.members.sort((r1, r2) {
          DateTime d1 = DateTime.parse(r1.created);
          DateTime d2 = DateTime.parse(r2.created);
          return d1.compareTo(d2);
        });
        await _changeRole(currentRoom, currentRoom.members.first, Role.ADMIN);
      }

      //Remove user from room
      await FirebaseFirestore.instance.collection(Const.rooms.name).doc(currentRoom.id).update({
        Const.members.name: FieldValue.arrayRemove(
          [userInRoom.toMap()],
        )
      });

      //Remove room id from user
      await addRoomIdToUser(
        userId: currentUser.id,
        roomId: currentRoom.id,
        add: false,
      );

      return currentRoom;
    });
  }

  void kickUser(RoomUser kickUser) async {
    final currentUser = ref.read(currentUserProvider).value!;
    final currentRoom = state.value;

    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      //Check room
      if (currentRoom?.id == null || currentRoom?.id == '') throw (Exception('No Room'));

      //Check admin
      final me = currentRoom!.members.where((u) => u.id == currentUser.id).first;
      if (me.role != Role.ADMIN) throw (Exception('User not admin'));

      final kickUserInRoom = currentRoom.members.where((u) => u.id == kickUser.id).first;

      //If you are admin and kickUser is not admin
      if (me.role.value <= kickUserInRoom.role.value) throw Exception('Not enough priviledge');

      //Remove kickUser from room
      await FirebaseFirestore.instance.collection(Const.rooms.name).doc(currentRoom.id).update({
        Const.members.name: FieldValue.arrayRemove(
          [kickUserInRoom.toMap()],
        )
      });

      //Remove room id from kickUser
      await addRoomIdToUser(
        userId: kickUserInRoom.id,
        roomId: currentRoom.id,
        add: false,
      );

      return currentRoom;
    });
  }

  FutureOr<void> updateRoomInfo({
    String? roomName,

    //
    String? avatar,
    String? description,
    Visible open = Visible.CLOSE,
  }) async {
    state = const AsyncValue.loading();
    final currentUser = ref.read(currentUserProvider).value;
    final currentRoom = ref.read(currentRoomProvider).value;

    // state = const AsyncValue.loading();
    //Check room
    if (currentUser != null && currentRoom?.id == null || currentRoom?.id == '') throw (Exception('No Room'));

    //Check admin
    if (currentRoom?.members.where((u) => u.id == currentUser!.id).first.role != Role.ADMIN) {
      throw (Exception('User not admin'));
    }

    await FirebaseFirestore.instance
        .collection(
          Const.rooms.name,
        )
        .doc(currentRoom!.id)
        .update(
          Room(
                nam: roomName,
                avatar: avatar,
                description: description,
                open: open,
              ).toMap() ??
              {},
        );

    ref.read(currentRoomProvider.notifier).updateRoom();

    state = const AsyncValue.data(null);
  }
}

@riverpod
bool isUserIsInRoom(IsUserIsInRoomRef ref) {
  final currentUser = ref.read(currentUserProvider).value!;
  final currentRoom = ref.read(currentRoomProvider).value;

  return (currentRoom?.members
          .where((e) =>
              e.id == currentUser.id && (e.role == Role.ADMIN || e.role == Role.MODERATOR || e.role == Role.USER))
          .isNotEmpty ??
      false);
}

@riverpod
RoomUser? currentRoomUser(CurrentRoomUserRef ref) {
  final currentUser = ref.read(currentUserProvider).value!;
  final currentRoom = ref.read(currentRoomProvider).value;

  return (currentRoom?.members.where(
    (e) => e.id == currentUser.id,
  ))?.toList().firstOrNull;
}

extension SuperRoomUser on RoomUser {
  bool get isAdminOrMod => role == Role.ADMIN || role == Role.MODERATOR;
  bool get isRequest => role == Role.REQUEST;
}

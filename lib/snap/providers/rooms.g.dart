// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rooms.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getRoomHash() => r'06141dae290f04986d456f4cecf19186555a2c17';

/// See also [getRoom].
@ProviderFor(getRoom)
final getRoomProvider = AutoDisposeFutureProvider<Room?>.internal(
  getRoom,
  name: r'getRoomProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getRoomHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetRoomRef = AutoDisposeFutureProviderRef<Room?>;
String _$getAllRoomsHash() => r'572226e8a83f7dd480f7e6a1ba378c414a612c05';

/// See also [getAllRooms].
@ProviderFor(getAllRooms)
final getAllRoomsProvider = AutoDisposeFutureProvider<List<Room?>>.internal(
  getAllRooms,
  name: r'getAllRoomsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllRoomsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllRoomsRef = AutoDisposeFutureProviderRef<List<Room?>>;
String _$roomStreamHash() => r'7d6fe5aeb534d80b666b2dceb9742cbf86af323c';

/// See also [roomStream].
@ProviderFor(roomStream)
final roomStreamProvider = AutoDisposeStreamProvider<Room?>.internal(
  roomStream,
  name: r'roomStreamProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roomStreamHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef RoomStreamRef = AutoDisposeStreamProviderRef<Room?>;
String _$isUserIsInRoomHash() => r'76a467860b56a9290458433cd6b2bcd3f17776c0';

/// See also [isUserIsInRoom].
@ProviderFor(isUserIsInRoom)
final isUserIsInRoomProvider = AutoDisposeProvider<bool>.internal(
  isUserIsInRoom,
  name: r'isUserIsInRoomProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$isUserIsInRoomHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IsUserIsInRoomRef = AutoDisposeProviderRef<bool>;
String _$currentRoomUserHash() => r'dbf3146a6c847760c798c6688b18001e093f8bdc';

/// See also [currentRoomUser].
@ProviderFor(currentRoomUser)
final currentRoomUserProvider = AutoDisposeProvider<RoomUser?>.internal(
  currentRoomUser,
  name: r'currentRoomUserProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$currentRoomUserHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef CurrentRoomUserRef = AutoDisposeProviderRef<RoomUser?>;
String _$roomTextHash() => r'd83e3f565e19c075dd855116dcc79f305a63b67b';

/// See also [RoomText].
@ProviderFor(RoomText)
final roomTextProvider =
    AutoDisposeAsyncNotifierProvider<RoomText, String?>.internal(
  RoomText.new,
  name: r'roomTextProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$roomTextHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$RoomText = AutoDisposeAsyncNotifier<String?>;
String _$currentRoomHash() => r'6fa33fc0ab9ab8877c6e53023b9c4cf7a626ac40';

/// See also [CurrentRoom].
@ProviderFor(CurrentRoom)
final currentRoomProvider =
    AutoDisposeAsyncNotifierProvider<CurrentRoom, Room?>.internal(
  CurrentRoom.new,
  name: r'currentRoomProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$currentRoomHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CurrentRoom = AutoDisposeAsyncNotifier<Room?>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions

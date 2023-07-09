// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getAllUsersHash() => r'65a445ec3915195525aaa57fbc954f394b346407';

/// See also [getAllUsers].
@ProviderFor(getAllUsers)
final getAllUsersProvider = AutoDisposeFutureProvider<List<User?>>.internal(
  getAllUsers,
  name: r'getAllUsersProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$getAllUsersHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef GetAllUsersRef = AutoDisposeFutureProviderRef<List<User?>>;
String _$getUserByIdHash() => r'e4d3bc079cf7d00a6b735c5b5d120781d5fdf960';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

typedef GetUserByIdRef = AutoDisposeFutureProviderRef<User?>;

/// See also [getUserById].
@ProviderFor(getUserById)
const getUserByIdProvider = GetUserByIdFamily();

/// See also [getUserById].
class GetUserByIdFamily extends Family<AsyncValue<User?>> {
  /// See also [getUserById].
  const GetUserByIdFamily();

  /// See also [getUserById].
  GetUserByIdProvider call(
    String userId,
  ) {
    return GetUserByIdProvider(
      userId,
    );
  }

  @override
  GetUserByIdProvider getProviderOverride(
    covariant GetUserByIdProvider provider,
  ) {
    return call(
      provider.userId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getUserByIdProvider';
}

/// See also [getUserById].
class GetUserByIdProvider extends AutoDisposeFutureProvider<User?> {
  /// See also [getUserById].
  GetUserByIdProvider(
    this.userId,
  ) : super.internal(
          (ref) => getUserById(
            ref,
            userId,
          ),
          from: getUserByIdProvider,
          name: r'getUserByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getUserByIdHash,
          dependencies: GetUserByIdFamily._dependencies,
          allTransitiveDependencies:
              GetUserByIdFamily._allTransitiveDependencies,
        );

  final String userId;

  @override
  bool operator ==(Object other) {
    return other is GetUserByIdProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$getUserByPhoneHash() => r'ee76e5cd03ea0dbeaa0812baf86f2d53e58d1600';
typedef GetUserByPhoneRef = AutoDisposeFutureProviderRef<User?>;

/// See also [getUserByPhone].
@ProviderFor(getUserByPhone)
const getUserByPhoneProvider = GetUserByPhoneFamily();

/// See also [getUserByPhone].
class GetUserByPhoneFamily extends Family<AsyncValue<User?>> {
  /// See also [getUserByPhone].
  const GetUserByPhoneFamily();

  /// See also [getUserByPhone].
  GetUserByPhoneProvider call(
    String phone,
  ) {
    return GetUserByPhoneProvider(
      phone,
    );
  }

  @override
  GetUserByPhoneProvider getProviderOverride(
    covariant GetUserByPhoneProvider provider,
  ) {
    return call(
      provider.phone,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'getUserByPhoneProvider';
}

/// See also [getUserByPhone].
class GetUserByPhoneProvider extends AutoDisposeFutureProvider<User?> {
  /// See also [getUserByPhone].
  GetUserByPhoneProvider(
    this.phone,
  ) : super.internal(
          (ref) => getUserByPhone(
            ref,
            phone,
          ),
          from: getUserByPhoneProvider,
          name: r'getUserByPhoneProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getUserByPhoneHash,
          dependencies: GetUserByPhoneFamily._dependencies,
          allTransitiveDependencies:
              GetUserByPhoneFamily._allTransitiveDependencies,
        );

  final String phone;

  @override
  bool operator ==(Object other) {
    return other is GetUserByPhoneProvider && other.phone == phone;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, phone.hashCode);

    return _SystemHash.finish(hash);
  }
}
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions

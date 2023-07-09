// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basic_app2.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$snakesHash() => r'e95655d2b23a460cd9ac1c8b5826f45ce4e3f389';

/// See also [snakes].
@ProviderFor(snakes)
final snakesProvider = AutoDisposeProvider<int>.internal(
  snakes,
  name: r'snakesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$snakesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SnakesRef = AutoDisposeProviderRef<int>;
String _$roverHash() => r'40df25075ea0242e44c2caa96ed38fd2e5f0ad94';

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

typedef RoverRef = AutoDisposeProviderRef<int>;

/// See also [rover].
@ProviderFor(rover)
const roverProvider = RoverFamily();

/// See also [rover].
class RoverFamily extends Family<int> {
  /// See also [rover].
  const RoverFamily();

  /// See also [rover].
  RoverProvider call({
    int? id,
  }) {
    return RoverProvider(
      id: id,
    );
  }

  @override
  RoverProvider getProviderOverride(
    covariant RoverProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'roverProvider';
}

/// See also [rover].
class RoverProvider extends AutoDisposeProvider<int> {
  /// See also [rover].
  RoverProvider({
    this.id,
  }) : super.internal(
          (ref) => rover(
            ref,
            id: id,
          ),
          from: roverProvider,
          name: r'roverProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$roverHash,
          dependencies: RoverFamily._dependencies,
          allTransitiveDependencies: RoverFamily._allTransitiveDependencies,
        );

  final int? id;

  @override
  bool operator ==(Object other) {
    return other is RoverProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$fetchItemHash() => r'adeb08ff55df447275ba3062abdcea8acf38997f';
typedef FetchItemRef = AutoDisposeFutureProviderRef<List<String>>;

/// See also [fetchItem].
@ProviderFor(fetchItem)
const fetchItemProvider = FetchItemFamily();

/// See also [fetchItem].
class FetchItemFamily extends Family<AsyncValue<List<String>>> {
  /// See also [fetchItem].
  const FetchItemFamily();

  /// See also [fetchItem].
  FetchItemProvider call({
    required int page,
  }) {
    return FetchItemProvider(
      page: page,
    );
  }

  @override
  FetchItemProvider getProviderOverride(
    covariant FetchItemProvider provider,
  ) {
    return call(
      page: provider.page,
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
  String? get name => r'fetchItemProvider';
}

/// See also [fetchItem].
class FetchItemProvider extends AutoDisposeFutureProvider<List<String>> {
  /// See also [fetchItem].
  FetchItemProvider({
    required this.page,
  }) : super.internal(
          (ref) => fetchItem(
            ref,
            page: page,
          ),
          from: fetchItemProvider,
          name: r'fetchItemProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchItemHash,
          dependencies: FetchItemFamily._dependencies,
          allTransitiveDependencies: FetchItemFamily._allTransitiveDependencies,
        );

  final int page;

  @override
  bool operator ==(Object other) {
    return other is FetchItemProvider && other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

String _$countHash() => r'e94d751ff366f081741350a573444b0fc220c671';

abstract class _$Count extends BuildlessAutoDisposeNotifier<int> {
  late final int? id;

  int build({
    int? id,
  });
}

/// See also [Count].
@ProviderFor(Count)
const countProvider = CountFamily();

/// See also [Count].
class CountFamily extends Family<int> {
  /// See also [Count].
  const CountFamily();

  /// See also [Count].
  CountProvider call({
    int? id,
  }) {
    return CountProvider(
      id: id,
    );
  }

  @override
  CountProvider getProviderOverride(
    covariant CountProvider provider,
  ) {
    return call(
      id: provider.id,
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
  String? get name => r'countProvider';
}

/// See also [Count].
class CountProvider extends AutoDisposeNotifierProviderImpl<Count, int> {
  /// See also [Count].
  CountProvider({
    this.id,
  }) : super.internal(
          () => Count()..id = id,
          from: countProvider,
          name: r'countProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$countHash,
          dependencies: CountFamily._dependencies,
          allTransitiveDependencies: CountFamily._allTransitiveDependencies,
        );

  final int? id;

  @override
  bool operator ==(Object other) {
    return other is CountProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  int runNotifierBuild(
    covariant Count notifier,
  ) {
    return notifier.build(
      id: id,
    );
  }
}

String _$crocoDileHash() => r'254411acf12500164cc559fa95ba69beb2421eea';

/// See also [CrocoDile].
@ProviderFor(CrocoDile)
final crocoDileProvider =
    AutoDisposeStreamNotifierProvider<CrocoDile, int>.internal(
  CrocoDile.new,
  name: r'crocoDileProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$crocoDileHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$CrocoDile = AutoDisposeStreamNotifier<int>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions

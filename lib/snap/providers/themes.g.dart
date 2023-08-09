// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'themes.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$allThemesHash() => r'65577e2c4ee629640b5e2fc5145db6fa2d4332b5';

/// See also [allThemes].
@ProviderFor(allThemes)
final allThemesProvider = AutoDisposeProvider<List<ThemeData>>.internal(
  allThemes,
  name: r'allThemesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$allThemesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef AllThemesRef = AutoDisposeProviderRef<List<ThemeData>>;
String _$globalThemeHash() => r'74b3726d06f61a3eb79d9fae19f54a0a84978f65';

/// See also [GlobalTheme].
@ProviderFor(GlobalTheme)
final globalThemeProvider =
    AutoDisposeNotifierProvider<GlobalTheme, ThemeData>.internal(
  GlobalTheme.new,
  name: r'globalThemeProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$globalThemeHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$GlobalTheme = AutoDisposeNotifier<ThemeData>;
// ignore_for_file: unnecessary_raw_strings, subtype_of_sealed_class, invalid_use_of_internal_member, do_not_use_environment, prefer_const_constructors, public_member_api_docs, avoid_private_typedef_functions

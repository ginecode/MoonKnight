import 'dart:developer';

import 'package:flutter/cupertino.dart' show CupertinoColors;
import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'local_cache.dart';

part 'themes.g.dart';

@riverpod
List<ThemeData> allThemes(AllThemesRef ref) {
  return [
    ThemeData(colorSchemeSeed: const Color(0xff6750a4), useMaterial3: true),
    ThemeData(
      colorSchemeSeed: const Color(0xff6750a4),
      useMaterial3: true,
      brightness: Brightness.light,
    ),
    ThemeData(
      colorSchemeSeed: const Color(0xff6750a4),
      useMaterial3: true,
      brightness: Brightness.dark,
    ),
    ThemeData.light().copyWith(
      primaryColor: const Color(0xff6750a4),
      useMaterial3: true,
    ),
    ThemeData.dark().copyWith(
      primaryColor: const Color(0xff6750a4),
      useMaterial3: true,
    ),
    ThemeData.light().copyWith(
      primaryColor: CupertinoColors.activeOrange,
    ),
    ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: CupertinoColors.systemPurple,
        brightness: Brightness.dark,
      ),
      primaryColor: CupertinoColors.systemPurple,
    ),
    ThemeData.light().copyWith(
      colorScheme: ColorScheme.fromSeed(seedColor: CupertinoColors.systemPurple, brightness: Brightness.dark),
      primaryColor: CupertinoColors.systemPurple,
    ),
    ThemeData.light().copyWith(
      primaryColorDark: Colors.orange,
      appBarTheme: const AppBarTheme(
        elevation: 1,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
        ),
      ),
      primaryColor: Colors.orange,
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: Colors.orange,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: Colors.orange,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        floatingLabelStyle: const TextStyle(
          color: Colors.orange,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
        focusColor: Colors.orange,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.orange,
            width: 2,
          ),
        ),
      ),
    ),
    ThemeData.dark().copyWith(
      primaryColor: CupertinoColors.systemYellow,
    ),
    ThemeData.from(
      colorScheme: ColorScheme.fromSeed(
        seedColor: CupertinoColors.activeGreen,
        brightness: Brightness.light,
      ),
    ),
    ThemeData.from(
      // useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CupertinoColors.destructiveRed,
        brightness: Brightness.dark,
      ),
    ),
    ThemeData.dark().copyWith(
      primaryColor: CupertinoColors.destructiveRed,
    ),
    ThemeData.dark().copyWith(
      primaryColor: CupertinoColors.destructiveRed,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CupertinoColors.destructiveRed,
        brightness: Brightness.dark,
      ),
    ),
    ThemeData.light().copyWith(
      primaryColor: CupertinoColors.destructiveRed,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CupertinoColors.destructiveRed,
        brightness: Brightness.light,
      ),
    ),
  ];
}

@riverpod
class GlobalTheme extends _$GlobalTheme {
  int _themeId = 0;

  @override
  ThemeData build() {
    final themes = ref.read(allThemesProvider);
    _themeId = _themeId % themes.length;
    return themes[_themeId];
  }

  void set(int i) {
    final themes = ref.read(allThemesProvider);
    final next = i % themes.length;
    state = themes[next];
    log('--------------------');
    log('Global Theme  ->  $next');
    log('--------------------');
    ref.read(localCacheProvider.notifier).saveSettings(next);
  }

  void add(int i) {
    final themes = ref.read(allThemesProvider);
    _themeId += i;
    final next = _themeId % themes.length;
    state = themes[next];
    ref.read(localCacheProvider.notifier).saveSettings(next);
  }
}

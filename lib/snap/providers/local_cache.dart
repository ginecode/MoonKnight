import 'dart:developer';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../cache/settings.dart';
import 'themes.dart';

part 'local_cache.g.dart';

@Riverpod(keepAlive: true)
class LocalCache extends _$LocalCache {
  Isar? get _isar => state.value;

  @override
  FutureOr<Isar> build() async {
    final dir = await getApplicationDocumentsDirectory();
    log('Isar : ${dir.path}');
    log(dir.uri.toFilePath());
    log(dir.uri.toString());
    log(dir.absolute.path);
    log(dir.absolute.parent.path);

    final isar = await Isar.open(
      [
        SettingSchema,
      ],
      directory: dir.path,
    );

    await loadTheme(isar);

    return isar;
  }

  void clear() async {
    await _isar?.writeTxn(
      () async {
        await _isar?.clear();
        // await _isar?.close();
      },
    );
  }

  void saveSettings(int theme) async {
    await _isar?.writeTxn(
      () async {
        await _isar?.settings.clear();

        await _isar?.settings.put(
          Setting()..theme = theme,
        );
      },
    );
  }

  Future<void> loadTheme(Isar isar) async {
    final count = await isar.settings.count();
    if (count == 1) {
      Setting? s = await isar.settings.get(1);
      if (s != null) {
        ref.read(globalThemeProvider.notifier).set(s.theme);
      }
    }
  }
}

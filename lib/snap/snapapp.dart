import 'dart:async';
import 'dart:developer';

import 'package:cloud_functions/cloud_functions.dart';
import 'package:country_picker/country_picker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:io';

import 'package:flutter_localizations/flutter_localizations.dart';

import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moonknight/insta/views/components/loading/loading_screen.dart';
import 'package:moonknight/snap/providers/loading.dart';
import 'package:moonknight/snap/providers/router.dart';
import 'package:moonknight/snap/providers/themes.dart';
import 'package:moonknight/snap/screens/barcode.dart';

import 'package:stack_trace/stack_trace.dart' as stack_trace;
import 'package:tamannaah/darkknight/debug_functions.dart';

import '../firebase_options.dart';
import 'providers/local_cache.dart';
// import '../goropod/utils/state_logger.dart';

void snap() {
  FlutterError.onError = (e) {
    lava('Flutter Error : ${e.toString()}');
  };

  FlutterError.presentError = (e) {
    lava('Flutter Error : ${e.toString()}');
  };

  FlutterError.demangleStackTrace = (StackTrace stack) {
    lava('Flutter Demangle : ${stack.toString()}');
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  runZonedGuarded(() async {
    WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

    if (Platform.isAndroid || Platform.isIOS || Platform.isMacOS) {
      await Firebase.initializeApp(
        name: 'moonknight',
        options: DefaultFirebaseOptions.currentPlatform,
      );

      try {
        String host = '192.168.43.229'; //'192.168.43.245'; //Platform.isAndroid ? "10.0.2.2" : "localhost";
        int firestorePort = 8080;
        // FirebaseFirestore.instance.settings = Settings(
        //   host: host+':$firestorePort',
        //   sslEnabled: false,
        //   persistenceEnabled: false,
        // );
        FirebaseFunctions.instance.useFunctionsEmulator(host, 5001);
        // FirebaseStorage.instance.useStorageEmulator(host, 9199);
        // FirebaseFirestore.instance.useFirestoreEmulator(host, firestorePort);
        // await FirebaseAuth.instance.useAuthEmulator(host, 9099);
      } catch (e, s) {
        lava('------------Emulator');
        lava(e);
        lava(s);
        lava('------------Emulator');
      }
    }

    final container = ProviderContainer();

    container.read(localCacheProvider);
    container.read(allCamerasProvider);

    runApp(
      ProviderScope(
        parent: container,
        // observers: [StateLogger()],
        child: const SnapApp(),
      ),
    );

    FlutterNativeSplash.remove();
  }, (error, stack) {
    log('Run Zoned Error : ${error.toString()} : ${stack.toString()}');
  });
}

class SnapApp extends ConsumerWidget {
  const SnapApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(globalThemeProvider);

    final goRouter = ref.watch(goRouterProvider);

    lava('Rebuild');

    return MaterialApp.router(
      routerConfig: goRouter,
      // routerConfig: _router,
      // themeMode: themeId ? ThemeMode.dark : ThemeMode.light,
      theme: theme.copyWith(
        useMaterial3: true,
      ),

//
      localizationsDelegates: const [
        CountryLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      // darkTheme: ThemeData.dark(),
    );
  }
}

void onionLoad(WidgetRef ref, BuildContext context) {
  ref.listen<bool>(
    isLoadingProvider,
    (_, isLoading) {
      print('Consumer Listening Loading : $isLoading');
      if (isLoading) {
        LoadingScreen.instance().show(
          context: context,
        );
      } else {
        LoadingScreen.instance().hide();
      }
    },
  );
}

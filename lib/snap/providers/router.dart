import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moonknight/snap/screens/snap_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tamannaah/router/special/error404.dart';

import '../../photoview/home_screen.dart';
import '../screens/snaphome.dart';
import '../screens/chat_screen.dart';
import '../screens/api_test.dart';
import '../screens/cupertino_test.dart';
import '../screens/login.dart';
import '../screens/splash.dart';
import 'auth.dart';

part 'router.g.dart';

final _key = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

@TypedGoRoute<HomeScreenRoute>(
  path: '/',
  routes: <TypedGoRoute<GoRouteData>>[
    TypedGoRoute<ChatScreenRoute>(
      path: 'r/:room',
    ),
  ],
)
@immutable
class HomeScreenRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SnapHome();
  }
}

@immutable
class ChatScreenRoute extends GoRouteData {
  final String room;

  const ChatScreenRoute(this.room);

  @override
  Widget build(BuildContext context, GoRouterState state) {
    // return ChatScreen(id: room);
    return FireChat(roomId: room);
  }
}

@TypedGoRoute<CupertinoTestRoute>(
  path: '/cupertino',
)
@immutable
class CupertinoTestRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const CupertinoTest();
  }
}

@TypedGoRoute<SplashRoute>(
  path: '/splash',
)
@immutable
class SplashRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SplashPage();
  }
}

@TypedGoRoute<ApiTestRoute>(
  path: '/api_test',
)
@immutable
class ApiTestRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const SnapRest();
  }
}

@TypedGoRoute<LoginRoute>(
  path: '/login',
)
@immutable
class LoginRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const Login();
    // return const SnapAuth();
  }
}

@TypedGoRoute<ProfileRoute>(
  path: '/profile',
)
@immutable
class ProfileRoute extends GoRouteData {
  @override
  Widget build(BuildContext context, GoRouterState state) {
    // return const Login();
    return const SnapAuth();
  }
}

@Riverpod(keepAlive: true)
GoRouter goRouter(GoRouterRef ref) {
  // final authListenable = ref.watch(authProvider.notifier);
  final user = ref.watch(currentUserProvider).value;

  return GoRouter(
    navigatorKey: _key,
    // refreshListenable: AuthChanges(),
    // refreshListenable: authListenable,
    debugLogDiagnostics: true,
    // initialLocation: HomeScreenRoute().location,
    routes: $appRoutes,
    errorBuilder: (context, state) {
      return AgniError(state.error);
    },
    redirect: (BuildContext context, GoRouterState state) {
      log('Redirect : $user');
      // print(
      // 'oo  : ${authState.isLoading} : ${authState.userId} : ${FirebaseAuth.instance.currentUser?.uid} : ${state.location}}');
      // if (authState.isLoading) return null;

      // final loggedIn = authState.userId != null;
      // final loggedIn = FirebaseAuth.instance.currentUser != null;
      final loggedIn = user != null;
      final isLoggingIn = state.location == LoginRoute().location;
      // print(' oo : ${authState.isLoading} : ${authState.userId} : ${state.location}');

      if (isLoggingIn) return loggedIn ? HomeScreenRoute().location : null;
      if (!isLoggingIn) return loggedIn ? null : LoginRoute().location;

      return null;
    },
  );
}

// class AuthChanges extends Listenable {
//   final Stream fireAuthChanges = FirebaseAuth.instance.authStateChanges();
//   @override
//   void addListener(VoidCallback listener) {
//     fireAuthChanges.listen((e) {
//       listener();
//     });
//   }

//   @override
//   void removeListener(VoidCallback listener) {}
// }

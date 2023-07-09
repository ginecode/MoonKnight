import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:moonknight/insta/state/auth/backend/authenticator.dart';
import 'package:moonknight/insta/state/auth/models/auth_result.dart';
import 'package:moonknight/insta/state/auth/models/auth_state.dart';
import 'package:moonknight/insta/state/posts/typedefs/user_id.dart';
import 'package:moonknight/insta/state/user_info/backend/user_info_storage.dart';

class AuthStateNotifier extends StateNotifier<AuthState> {
  final _authenticator = const Authenticator();
  final _userInfoStorage = const UserInfoStorage();

  AuthStateNotifier() : super(const AuthState.unknown()) {
    if (_authenticator.isAlreadyLoggedIn) {
      state = AuthState(
        result: AuthResult.success,
        isLoading: false,
        userId: _authenticator.user?.uid,
      );
    }
  }

  Future<void> logOut() async {
    state = state.copiedWithIsLoading(true);
    await _authenticator.logOut();
    state = const AuthState.unknown();
  }

  Future<void> anonymousLogin() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginAnonymously();
    final userId = _authenticator.user?.uid;
    print(userId.toString());
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.user?.uid,
    );
  }

  Future<void> loginWithGoogle() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithGoogle();
    final userId = _authenticator.user?.uid;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.user?.uid,
    );
  }

  Future<void> loginWithFacebook() async {
    state = state.copiedWithIsLoading(true);
    final result = await _authenticator.loginWithFacebook();
    final userId = _authenticator.user?.uid;
    if (result == AuthResult.success && userId != null) {
      await saveUserInfo(userId: userId);
    }
    state = AuthState(
      result: result,
      isLoading: false,
      userId: _authenticator.user?.uid,
    );
  }

  Future<void> saveUserInfo({
    required UserId userId,
  }) =>
      _userInfoStorage.saveUserInfo(
        userId: userId,
        displayName: _authenticator.user?.displayName ?? 'name',
        email: _authenticator.user?.email,
      );
}

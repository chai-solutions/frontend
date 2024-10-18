import 'package:chai/providers/secure_storage.dart';
import 'package:chai/repository/auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth.g.dart';

enum AuthStatus { loggedIn, loggedOut, unknown }

@riverpod
class AuthController extends _$AuthController {
  @override
  FutureOr<AuthStatus> build() async {
    return await authStatus();
  }

  Future<String?> login({
    required String email,
    required String password,
  }) async {
    final secureStorage = ref.read(secureStorageProvider.notifier);
    final authRepo = ref.read(authRepoProvider);

    var success = false;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final token = await authRepo.login(email, password);
      await secureStorage.setStorageValue(SecureStorageKeys.authToken, token);
      success = true;
      return AuthStatus.loggedIn;
    });

    return success ? null : 'Error logging in.';
  }

  Future<AuthStatus> authStatus() async {
    final secureStorage = ref.read(secureStorageProvider.notifier);

    state = await AsyncValue.guard(() async {
      final token = await secureStorage.read(SecureStorageKeys.authToken);
      return (token != null) ? AuthStatus.loggedIn : AuthStatus.loggedOut;
    });

    return state.valueOrNull ?? AuthStatus.unknown;
  }

  Future<void> logout() async {
    final authRepo = ref.read(authRepoProvider);
    final secureStorage = ref.read(secureStorageProvider.notifier);

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await authRepo.logout();
      await secureStorage.setStorageValue(SecureStorageKeys.authToken, null);
      return AuthStatus.loggedOut;
    });
  }
}

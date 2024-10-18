import 'package:chai/repository/user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'create_account.g.dart';

@riverpod
class CreateAccountController extends _$CreateAccountController {
  @override
  FutureOr<void> build() async {}

  Future<String?> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    final userRepo = ref.read(userRepoProvider);

    var success = false;

    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      await userRepo.createAccount(
        name: name,
        email: email,
        password: password,
      );

      success = true;
    });

    return success
        ? null
        : 'An error has occurred while creating your account.';
  }
}

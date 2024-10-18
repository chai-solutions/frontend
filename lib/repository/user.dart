import 'package:chai/providers/http_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'user.g.dart';

class UserRepository {
  final HttpClient client;

  UserRepository(this.client);

  Future<void> createAccount({
    required String name,
    required String email,
    required String password,
  }) async {
    final res = await client.post('/users', body: {
      "name": name,
      "email": email,
      "password": password,
    });

    if (res.statusCode != 200) {
      throw Exception('Account not created successfully.');
    }
  }
}

@riverpod
UserRepository userRepo(UserRepoRef ref) {
  final client = ref.watch(httpClientProvider);
  final repo = UserRepository(client);
  return repo;
}

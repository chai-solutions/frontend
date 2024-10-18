import 'dart:convert';

import 'package:chai/models/user/user.dart';
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

  Future<User> currentUser() async {
    final res = await client.get('/users/@me');
    if (res.statusCode != 200) {
      throw Exception('User request exited with status ${res.statusCode}');
    }
    final json = jsonDecode(res.body);
    return User.fromJson(json);
  }
}

@riverpod
UserRepository userRepo(UserRepoRef ref) {
  final client = ref.watch(httpClientProvider);
  final repo = UserRepository(client);
  return repo;
}

@riverpod
Future<User> currentUser(CurrentUserRef ref) async {
  return await ref.watch(userRepoProvider).currentUser();
}

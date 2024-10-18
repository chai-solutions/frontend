import 'dart:convert';

import 'package:chai/providers/http_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth.g.dart';

class AuthRepository {
  final HttpClient client;

  AuthRepository(this.client);

  /// Call /login to obtain a session token. This can be
  /// used to authenticate to the rest of the API with a
  /// bearer token
  Future<String> login(String email, String password) async {
    final res = await client.post('/login', body: {
      "email": email,
      "password": password,
    });

    if (res.statusCode == 403) {
      throw Exception('Account not found.');
    } else if (res.statusCode != 200) {
      throw Exception('Internal server error. Try again later.');
    }
    final json = jsonDecode(res.body) as Map<String, dynamic>;
    return json['authorization'];
  }

  /// Revoke the session's bearer token by calling /logout.
  Future<void> logout() async {
    final res = await client.delete('/logout');
    if (res.statusCode != 204) {
      throw Exception('Internal server error. Try again later.');
    }
  }
}

@riverpod
AuthRepository authRepo(AuthRepoRef ref) {
  final client = ref.watch(httpClientProvider);
  final repo = AuthRepository(client);
  return repo;
}

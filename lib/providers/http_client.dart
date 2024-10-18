import 'dart:convert';
import 'package:chai/providers/secure_storage.dart';
import 'package:chai/utils/env.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_client.g.dart';

@riverpod
HttpClient httpClient(HttpClientRef ref) {
  final secureStorage = ref.watch(secureStorageProvider);

  final token = secureStorage.when(
    data: (t) => t[SecureStorageKeys.authToken],
    loading: () => null,
    error: (_, __) => null,
  );
  final baseUrl = Env().baseURL;

  return HttpClient(baseUrl: baseUrl, token: token);
}

class HttpClient {
  final String baseUrl;
  final String? token;

  HttpClient({required this.baseUrl, this.token});

  Future<http.Response> get(String path) {
    return http.get(
      Uri.parse('$baseUrl$path'),
      headers: _buildHeaders(),
    );
  }

  Future<http.Response> post(String path,
      {required Map<String, dynamic> body}) {
    return http.post(
      Uri.parse('$baseUrl$path'),
      headers: _buildHeaders(),
      body: json.encode(body),
    );
  }

  Future<http.Response> put(String path, {required Map<String, dynamic> body}) {
    return http.put(
      Uri.parse('$baseUrl$path'),
      headers: _buildHeaders(),
      body: json.encode(body),
    );
  }

  Future<http.Response> patch(String path,
      {required Map<String, dynamic> body}) {
    return http.patch(
      Uri.parse('$baseUrl$path'),
      headers: _buildHeaders(),
      body: json.encode(body),
    );
  }

  Future<http.Response> delete(String path) {
    return http.delete(
      Uri.parse('$baseUrl$path'),
      headers: _buildHeaders(),
    );
  }

  Map<String, String> _buildHeaders() {
    var headers = {
      'Content-Type': 'application/json',
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    return headers;
  }
}

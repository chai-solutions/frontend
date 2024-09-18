import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'http_client.g.dart';

@Riverpod(dependencies: [])
Client httpClient(HttpClientRef ref) {
  const baseUrl = String.fromEnvironment('BASE_URL');
  if (baseUrl.isEmpty) {
    throw Exception('BASE_URL is empty, this must be specified');
  }

  return Client(baseUrl: baseUrl);
}

class Client {
  final String baseUrl;

  Client({required this.baseUrl});

  Future<http.Response> get(String path) {
    return http.get(Uri.parse('$baseUrl$path'));
  }

  Future<http.Response> post(String path,
      {required Map<String, dynamic> body}) {
    return http.post(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }

  Future<http.Response> put(String path, {required Map<String, dynamic> body}) {
    return http.put(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }

  Future<http.Response> patch(String path,
      {required Map<String, dynamic> body}) {
    return http.patch(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );
  }

  Future<http.Response> delete(String path) {
    return http.delete(
      Uri.parse('$baseUrl$path'),
      headers: {'Content-Type': 'application/json'},
    );
  }
}

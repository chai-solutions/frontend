import 'dart:convert';

import 'package:chai/providers/http_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:chai/models/models.dart';

part 'hello.g.dart';

@riverpod
Future<HelloResponse> getHello(GetHelloRef ref) async {
  final client = ref.watch(httpClientProvider);
  final response = await client.get('/hello');
  await Future.delayed(const Duration(milliseconds: 500));
  final json = jsonDecode(response.body) as Map<String, dynamic>;
  return HelloResponse.fromJson(json);
}

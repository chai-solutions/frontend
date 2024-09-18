import 'package:freezed_annotation/freezed_annotation.dart';

part 'hello.freezed.dart';
part 'hello.g.dart';

@freezed
class HelloResponse with _$HelloResponse {
  factory HelloResponse({
    required String message,
    required int number,
  }) = _HelloResponse;

  factory HelloResponse.fromJson(Map<String, dynamic> json) =>
      _$HelloResponseFromJson(json);
}

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hello.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$HelloResponseImpl _$$HelloResponseImplFromJson(Map<String, dynamic> json) =>
    _$HelloResponseImpl(
      message: json['message'] as String,
      number: (json['number'] as num).toInt(),
    );

Map<String, dynamic> _$$HelloResponseImplToJson(_$HelloResponseImpl instance) =>
    <String, dynamic>{
      'message': instance.message,
      'number': instance.number,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'summary.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SummaryImpl _$$SummaryImplFromJson(Map<String, dynamic> json) =>
    _$SummaryImpl(
      conversation: json['conversation'] as String,
      content: json['content'] as String,
      sendAt: (json['sendAt'] as num).toInt(),
    );

Map<String, dynamic> _$$SummaryImplToJson(_$SummaryImpl instance) =>
    <String, dynamic>{
      'conversation': instance.conversation,
      'content': instance.content,
      'sendAt': instance.sendAt,
    };

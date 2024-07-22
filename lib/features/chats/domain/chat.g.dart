// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ChatImpl _$$ChatImplFromJson(Map<String, dynamic> json) => _$ChatImpl(
      conversation: json['conversation'] as String,
      sender: json['sender'] as String,
      receiver: json['receiver'] as String,
      content: json['content'] as String,
      sendAt: (json['sendAt'] as num).toInt(),
    );

Map<String, dynamic> _$$ChatImplToJson(_$ChatImpl instance) =>
    <String, dynamic>{
      'conversation': instance.conversation,
      'sender': instance.sender,
      'receiver': instance.receiver,
      'content': instance.content,
      'sendAt': instance.sendAt,
    };

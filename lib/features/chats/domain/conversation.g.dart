// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConversationImpl _$$ConversationImplFromJson(Map<String, dynamic> json) =>
    _$ConversationImpl(
      id: json['id'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      participantProfile: (json['participantProfile'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
      lastMessage: json['lastMessage'] as String,
    );

Map<String, dynamic> _$$ConversationImplToJson(_$ConversationImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'participants': instance.participants,
      'participantProfile': instance.participantProfile,
      'lastMessage': instance.lastMessage,
    };

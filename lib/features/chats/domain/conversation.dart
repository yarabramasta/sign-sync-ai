import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:signsyncai/features/auth/domain/account.dart';
import 'package:signsyncai/services/firebase.dart';

part 'conversation.freezed.dart';
part 'conversation.g.dart';

@freezed
class Conversation with _$Conversation {
  const factory Conversation({
    required String id,
    required List<String> participants,
    required List<Map<String, dynamic>> participantProfile,
    required String lastMessage,
  }) = _Conversation;

  factory Conversation.fromJson(Map<String, dynamic> json) =>
      _$ConversationFromJson(json);

  static CollectionReference<Conversation> get col {
    return db.collection('conversations').withConverter(
          fromFirestore: (data, _) => Conversation.fromJson(data.data()!),
          toFirestore: (data, _) => data.toJson(),
        );
  }
}

extension EntityExtensions on Conversation {
  Account getOtherParticipant(String id) {
    final index = participantProfile.firstWhere((it) => it['code'] != id);
    return Account.fromJson(index);
  }
}

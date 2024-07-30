import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:signsyncai/services/firebase.dart';

part 'chat.freezed.dart';
part 'chat.g.dart';

@freezed
class Chat with _$Chat {
  const factory Chat({
    required String conversation,
    required String sender,
    required String receiver,
    required String content,
    required int sendAt,
  }) = _Chat;

  factory Chat.fromJson(Map<String, dynamic> json) => _$ChatFromJson(json);

  static CollectionReference<Chat> get col {
    return db.collection("chats").withConverter(
          fromFirestore: (snapshot, _) => Chat.fromJson(snapshot.data()!),
          toFirestore: (snapshot, _) => snapshot.toJson(),
        );
  }
}

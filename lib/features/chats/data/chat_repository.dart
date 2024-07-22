import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/features/chats/domain/chat.dart';
import 'package:signsyncai/features/chats/domain/conversation.dart';

class ChatRepository {
  Stream<List<Conversation>> getConversations(String id) {
    return Conversation.col
        .where('participants', arrayContainsAny: [id])
        .snapshots()
        .asyncMap((event) {
          return event.docs.map((e) => e.data()).toList();
        });
  }

  Stream<List<Chat>> getMessages(String conversationId) {
    return Chat.col
        .where('conversation', isEqualTo: conversationId)
        .orderBy('sendAt', descending: true)
        .snapshots()
        .asyncMap((e) => e.docs.map((e) => e.data()).toList());
  }

  Future<List<Chat>> getHistoryMessage(String conversationId) async {
    final data = await Chat.col
        .where('conversation', isEqualTo: conversationId)
        .orderBy('sendAt', descending: true)
        .get();

    return data.docs.map((e) => e.data()).toList();
  }

  Future<void> sendMessage(
    String conversationId,
    String senderId,
    String receiverId,
    String message,
  ) async {
    await Chat.col.add(Chat(
      conversation: conversationId,
      sender: senderId,
      receiver: receiverId,
      content: message,
      sendAt: Timestamp.now().microsecondsSinceEpoch,
    ));

    await Conversation.col.doc(conversationId).update({
      'lastMessage': message,
    });
  }

  Future<void> createConversation(
    List<String> participants,
    List<Map<String, dynamic>> participantProfile,
  ) async {
    final doc = Conversation.col.doc(participants.join(":"));
    await doc.set(Conversation(
      id: doc.id,
      participants: participants,
      participantProfile: participantProfile,
      lastMessage: "",
    ));
  }
}

ChatRepository chatRepo(CapsuleHandle use) => ChatRepository();

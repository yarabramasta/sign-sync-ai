import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/exceptions/summarry_exception.dart';
import 'package:signsyncai/features/chats/domain/chat.dart';
import 'package:signsyncai/features/chats/domain/conversation.dart';
import 'package:signsyncai/features/chats/domain/summary.dart';

class ChatRepository {
  Stream<List<Conversation>> getConversations(String id) {
    return Conversation.col
        .where('participants', arrayContainsAny: [id])
        .snapshots()
        .asyncMap((event) {
          try {
            return event.docs.map((e) => e.data()).toList();
          } catch (e) {
            return [];
          }
        });
  }

  Stream<List<Chat>> getMessages(String conversationId) {
    return Chat.col
        .where('conversation', isEqualTo: conversationId)
        .orderBy('sendAt', descending: true)
        .snapshots()
        .asyncMap((e) {
      try {
        return e.docs.map((e) => e.data()).toList();
      } catch (e) {
        return [];
      }
    });
  }

  Future<List<Chat>> getHistoryMessage(String conversationId) async {
    try {
      final lastMessageSnapshot = await Summary.col
          .where('conversation', isEqualTo: conversationId)
          .orderBy('sendAt', descending: true)
          .limit(1)
          .get();

      if (lastMessageSnapshot.docs.isEmpty) {
        final data = await Chat.col
            .where('conversation', isEqualTo: conversationId)
            .orderBy('sendAt', descending: true)
            .get();

        return data.docs.map((e) => e.data()).toList();
      }

      final lastMessage = lastMessageSnapshot.docs[0].data();
      final lastMessageMicroseconds = lastMessage.sendAt;

      int dayDifference = _calculateDayDifference(
        DateTime.fromMicrosecondsSinceEpoch(lastMessageMicroseconds),
      );

      final data = await Chat.col
          .where('conversation', isEqualTo: conversationId)
          .where('sendAt', isGreaterThan: lastMessageMicroseconds)
          .orderBy('sendAt', descending: true)
          .get();

      if ((data.docs.length < 10 && dayDifference < 3)) {
        throw SummarryException(
          "Coba lagi nanti, ringkasan hanya bisa dibuat setelah 3 hari",
        );
      }

      return data.docs.map((e) => e.data()).toList();
    } catch (e) {
      if (e is SummarryException) {
        throw SummarryException(e.message);
      }

      return Future.error(e);
    }
  }

  Future<void> sendMessage(
    String conversationId,
    String senderId,
    String receiverId,
    String message,
  ) async {
    try {
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
    } catch (e) {
      Future.error(e);
    }
  }

  Future<Conversation> createConversation(
    List<String> participants,
    List<Map<String, dynamic>> participantProfile,
  ) async {
    try {
      final doc = Conversation.col.doc(participants.join(":"));
      var conversation = await doc.get();

      if (conversation.exists) {
        return conversation.data()!;
      }

      final data = Conversation(
        id: doc.id,
        participants: participants,
        participantProfile: participantProfile,
        lastMessage: "",
      );

      await doc.set(data);
      return data;
    } catch (e) {
      // Handle error appropriately
      return Future.error(e);
    }
  }

  Future<void> saveSummaryMessage(
    String conversationId,
    String content,
  ) async {
    try {
      await Summary.col.add(Summary(
        conversation: conversationId,
        content: content,
        sendAt: Timestamp.now().microsecondsSinceEpoch,
      ));
    } catch (e) {
      log(e.toString());
    }
  }

  Stream<List<Summary>> getSummaryMessage(String conversationId) {
    return Summary.col
        .where('conversation', isEqualTo: conversationId)
        .orderBy('sendAt', descending: true)
        .snapshots()
        .asyncMap((e) {
      try {
        return e.docs.map((e) => e.data()).toList();
      } catch (e) {
        return [];
      }
    });
  }

  int _calculateDayDifference(DateTime targetTime) {
    final now = DateTime.now();
    final targetTimeLocal = targetTime.toLocal();
    final differenceInMillis = now.difference(targetTimeLocal).inMilliseconds;
    final differenceInDays = (differenceInMillis / 86400000).floor();

    return differenceInDays;
  }
}

ChatRepository chatRepo(CapsuleHandle use) => ChatRepository();

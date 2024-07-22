import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/features/chats/data/chat_repository.dart';
import 'package:signsyncai/features/chats/domain/conversation.dart';
import 'package:signsyncai/services/firebase.dart';

(AsyncValue<Stream<List<Conversation>>>?, Function(String)) fetchConversations(
  CapsuleHandle use,
) {
  final repo = use(chatRepo);
  final (:state, :mutate, clear: _) =
      use.mutation<Stream<List<Conversation>>>();

  void fetch(String id) {
    mutate(Future.microtask(() => repo.getConversations(id)));
  }

  return (state, fetch);
}

(AsyncValue<void>?, Function(String, String, String, String)) sendMessage(
  CapsuleHandle use,
) {
  final repo = use(chatRepo);
  final (:state, :mutate, clear: _) = use.mutation<void>();

  void send(String conversationId, String senderId, String receiverId,
      String message) {
    mutate(Future.microtask(() => repo.sendMessage(
          conversationId,
          senderId,
          receiverId,
          message,
        )));
  }

  return (state, send);
}

(
  AsyncValue<GenerateContentResponse>?,
  void Function(Conversation conversation, BuildContext ctx)
) sumaryMessage(
  CapsuleHandle use,
) {
  final repo = use(chatRepo);
  final (:state, :mutate, clear: _) = use.mutation<GenerateContentResponse>();

  void summary(Conversation conversation, BuildContext ctx) async {
    final data = await repo.getHistoryMessage(conversation.id);
    var content =
        "data percakapan :\n\n ${data.map((e) => "${DateTime.fromMicrosecondsSinceEpoch(e.sendAt).toString()} ${e.content}").join("\n")}";

    final generatedSummary = ai().generateContent([Content.text(content)]);

    mutate(generatedSummary);
  }

  return (state, summary);
}

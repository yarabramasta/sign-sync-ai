import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/exceptions/summarry_exception.dart';
import 'package:signsyncai/features/auth/domain/account.dart';
import 'package:signsyncai/features/chats/data/chat_repository.dart';
import 'package:signsyncai/features/chats/domain/conversation.dart';
import 'package:signsyncai/screens/room_chat.dart';
import 'package:signsyncai/services/algolia.dart' as algolia;
import 'package:signsyncai/services/firebase.dart';
import 'package:signsyncai/ui/toast.dart';

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

(
  AsyncValue<void>?,
  Function(BuildContext context, Map<String, Account>),
) createConversation(CapsuleHandle use) {
  final repo = use(chatRepo);
  final (:state, mutate: _, clear: _) = use.mutation<void>();

  void call(BuildContext context, Map<String, Account> participants) async {
    final participantsId = participants.values.map((e) => e.code).toList();
    final profile = participants.values.map((e) => e.toJson()).toList();

    Conversation? conversation;

    try {
      conversation = await repo.createConversation(
        participantsId,
        profile,
      );
    } catch (e) {
      if (context.mounted) {
        context.toast.error(
          autoCloseDuration: const Duration(seconds: 3),
          message: 'Gagal memulai percakapan!',
        );
        return;
      }
    }

    if (context.mounted) {
      Navigator.of(context)
          .push(RoomChat.route(conversation!, participants['receiver']!));
    }
  }

  return (state, call);
}

(
  AsyncValue<void>?,
  Function(BuildContext, String, String, String, String),
) sendMessage(CapsuleHandle use) {
  final repo = use(chatRepo);
  final (:state, :mutate, clear: _) = use.mutation<void>();

  void send(BuildContext context, String conversationId, String senderId,
      String receiverId, String message) {
    mutate(Future.microtask(() async {
      try {
        await repo.sendMessage(
          conversationId,
          senderId,
          receiverId,
          message,
        );
      } catch (e) {
        if (context.mounted) {
          context.toast.error(
            autoCloseDuration: const Duration(seconds: 3),
            message: 'Gagal mengirim pesan!',
          );
        }
      }
    }));
  }

  return (state, send);
}

(
  AsyncValue<List<Account>>?,
  void Function(String? query, BuildContext ctx),
) searchLecture(CapsuleHandle use) {
  final (:state, :mutate, clear: _) = use.mutation<List<Account>>();

  void call(String? query, BuildContext ctx) async {
    mutate(algolia.searchLecture(query));
  }

  return (state, call);
}

(
  AsyncValue<void>?,
  void Function(Conversation conversation, BuildContext ctx),
) sumaryMessage(CapsuleHandle use) {
  final repo = use(chatRepo);
  final (:state, :mutate, clear: _) = use.mutation<void>();

  void summary(Conversation conversation, BuildContext ctx) {
    mutate(Future.microtask(() async {
      try {
        final data = await repo.getHistoryMessage(conversation.id);
        var content =
            "data percakapan :\n\n ${data.map((e) => "${DateTime.fromMicrosecondsSinceEpoch(e.sendAt).toString()} ${e.content}").join("\n")}";
        final generatedSummary =
            await ai().generateContent([Content.text(content)]);

        repo.saveSummaryMessage(conversation.id, generatedSummary.text!);
      } on SummarryException catch (e) {
        if (ctx.mounted) {
          ctx.toast.info(
            autoCloseDuration: const Duration(seconds: 3),
            message: e.message,
          );
          return;
        }
      } catch (e) {
        if (ctx.mounted) {
          ctx.toast.error(
            autoCloseDuration: const Duration(seconds: 3),
            message: 'Terjadi kesalahan saat meringkas!',
          );
          return;
        }
      }
    }));
  }

  return (state, summary);
}

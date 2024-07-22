import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/features/auth/domain/account.dart';
import 'package:signsyncai/features/auth/presentation/store.dart';
import 'package:signsyncai/features/chats/data/chat_repository.dart';
import 'package:signsyncai/features/chats/domain/chat.dart';
import 'package:signsyncai/features/chats/domain/conversation.dart';
import 'package:signsyncai/features/chats/presentation/widget/button_send.dart';
import 'package:signsyncai/features/chats/presentation/widget/header.dart';
import 'package:signsyncai/features/chats/presentation/widget/voice_record.dart';
import 'package:signsyncai/screens/sumarry.dart';

class RoomChat extends RearchConsumer {
  final Conversation conversation;
  final Account account;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  RoomChat({
    super.key,
    required this.conversation,
    required this.account,
  });

  static MaterialPageRoute Function(Conversation, Account) get route {
    return (Conversation id, Account acc) => MaterialPageRoute(
          builder: (context) => RoomChat(
            conversation: id,
            account: acc,
          ),
        );
  }

  @override
  Widget build(BuildContext context, WidgetHandle use) {
    return RearchBuilder(builder: (data, use) {
      final cred = use(account$);

      return Scaffold(
        appBar: ChatRoomHeader(
          drawerController: _scaffoldKey,
          userName: account.name!,
          userImageUrl: account.avatar!,
        ),
        drawer: SummarizerDrawer(
          conversation: conversation,
          date: DateTime(2024, 7, 8),
        ),
        body: switchCase(
          cred,
          (Account acc) => buildChatUi(acc),
          () => const Center(child: Text('Loading...')),
        ),
      );
    });
  }

  List<ChatMessage>? mapMessages(List<Chat> chats, Account account) {
    return chats.map((chat) {
      return ChatMessage(
        user: account.code == chat.sender
            ? ChatUser(
                firstName: account.name!,
                id: account.code,
              )
            : ChatUser(
                firstName: this.account.name!,
                id: this.account.code,
              ),
        text: chat.content,
        createdAt: DateTime.fromMicrosecondsSinceEpoch(chat.sendAt),
      );
    }).toList();
  }

  Widget buildChatUi(Account account) {
    return RearchBuilder(builder: (ctx, use) {
      final repo = use(chatRepo);

      return StreamBuilder(
        stream: repo.getMessages(conversation.id),
        builder: (ctx, snapshot) {
          if (snapshot.hasData) {
            var messages = mapMessages(snapshot.data as List<Chat>, account);

            return DashChat(
              currentUser: ChatUser(
                firstName: account.name!,
                id: account.code,
                profileImage: account.avatar!,
              ),
              messageOptions: const MessageOptions(
                currentUserContainerColor: Color(0xFFD4E3FF),
                showTime: true,
                currentUserTextColor: Colors.black,
                showOtherUsersAvatar: false,
              ),
              inputOptions: InputOptions(
                  alwaysShowSend: true,
                  sendButtonBuilder: (send) =>
                      PaperPlaneButton(onPressed: send),
                  leading: [
                    VoiceRecordButton(onPressed: () {}),
                  ]),
              onSend: (message) {
                repo.sendMessage(
                  conversation.id,
                  account.code,
                  this.account.code,
                  message.text,
                );
              },
              messages: messages ?? [],
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      );
    });
  }

  // switchCase
  Widget switchCase(
      AsyncValue<Account?> condition, Widget Function(Account acc) trueCase,
      [Widget Function()? falseCase]) {
    return switch (condition) {
      AsyncData(:final data) => trueCase(data!),
      _ => falseCase?.call() ?? const SizedBox()
    };
  }
}

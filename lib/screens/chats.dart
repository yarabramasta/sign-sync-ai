import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/features/auth/domain/account.dart';
import 'package:signsyncai/features/auth/presentation/store.dart';
import 'package:signsyncai/features/chats/data/chat_repository.dart';
import 'package:signsyncai/features/chats/domain/conversation.dart';
import 'package:signsyncai/features/chats/presentation/widget/list_conversation.dart';
import 'package:signsyncai/features/chats/presentation/widget/search_lecture_bottomsheet.dart';
import 'package:signsyncai/ui/utils/sizes.dart';

class ChatsScreen extends RearchConsumer {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetHandle use) {
    final repo = use(chatRepo);

    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: FloatingActionButton(
          onPressed: () => showSearchLectureBottomSheet(context),
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
          child: const PhosphorIcon(PhosphorIconsDuotone.chatTeardropDots),
        ),
      ),
      body: RearchBuilder(builder: (data, use) {
        final acc = use(account$);

        return switchCase(
          acc,
          (acc) => StreamBuilder<List<Conversation>>(
            stream: repo.getConversations(acc!.code),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data?.length,
                  itemBuilder: (context, index) {
                    final conversation = snapshot.data![index];
                    return ListConversation(
                      account: conversation.getOtherParticipant(acc.code),
                      conversation: conversation,
                    );
                  },
                );
              }

              return const Center(child: CircularProgressIndicator());
            },
          ),
          () => const Center(child: Text('Loading...')),
        );
      }),
    );
  }

  // switchCase
  Widget switchCase(
      AsyncValue<Account?> condition, Widget Function(Account? acc) trueCase,
      [Widget Function()? falseCase]) {
    return switch (condition) {
      AsyncData(:final data) => trueCase(data),
      _ => falseCase?.call() ?? const SizedBox()
    };
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:intl/intl.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/features/chats/data/chat_repository.dart';
import 'package:signsyncai/features/chats/domain/conversation.dart';
import 'package:signsyncai/features/chats/domain/summary.dart';
import 'package:signsyncai/features/chats/presentation/actions.dart'; // Untuk format tanggal

class SummarizerDrawer extends RearchConsumer {
  final Conversation conversation;
  final DateTime date;

  const SummarizerDrawer({
    super.key,
    required this.conversation,
    required this.date,
  });

  @override
  Widget build(BuildContext context, WidgetHandle use) {
    final repo = use(chatRepo);
    final (summary, fetchSumarize) = use(sumaryMessage);

    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: Flex(
        direction: Axis.vertical,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 30.0, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiaryContainer,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.tertiary,
                    ),
                  ),
                  child: Row(
                    children: [
                      PhosphorIcon(
                        PhosphorIconsRegular.magicWand,
                        color: Theme.of(context).colorScheme.tertiary,
                        size: 16,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'AI Summarizer',
                        style: TextStyle(
                          fontSize: 14,
                          color: Theme.of(context).colorScheme.tertiary,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: MediaQuery.of(context).size.height * 0.74,
            child: StreamBuilder<List<Summary>>(
              stream: repo.getSummaryMessage(conversation.id),
              builder: (context, data) {
                if (data.hasData) {
                  return ListView.builder(
                    reverse: true,
                    itemCount: data.data!.length,
                    itemBuilder: (context, index) {
                      final sumarry = data.data![index];
                      return buildCard(context, sumarry);
                    },
                  );
                }

                return const Center(child: Text('No data'));
              },
            ),
          ),
          const Spacer(),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surfaceContainerHigh,
            ),
            child: GestureDetector(
              onTap: () => fetchSumarize(conversation, context),
              child: Container(
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.primary,
                  borderRadius: BorderRadius.circular(23),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const PhosphorIcon(
                      PhosphorIconsRegular.magicWand,
                      color: Colors.white,
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    RearchBuilder(builder: (context, use) {
                      return Text(
                        summary is AsyncLoading ? 'Generating' : 'Summarize',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      );
                    }),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget buildCard(BuildContext ctx, Summary sumarry) {
    return Column(
      children: [
        Text(
          DateFormat('MMMM d, yyyy', 'id_ID').format(
            DateTime.fromMicrosecondsSinceEpoch(sumarry.sendAt),
          ),
          style: const TextStyle(fontSize: 14, color: Colors.grey),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Theme.of(ctx).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            sumarry.content,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(ctx).colorScheme.primary,
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:firebase_vertexai/firebase_vertexai.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:intl/intl.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/features/chats/domain/conversation.dart';
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
    final (summary, fetchSumarize) = use(sumaryMessage);

    return Drawer(
      width: MediaQuery.of(context).size.width,
      child: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                ElevatedButton(
                  onPressed: () async {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                  ),
                  child: const Text('AI Summarizer',
                      style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              DateFormat('MMMM d, yyyy', 'id_ID')
                  .format(date), // Format tanggal
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 10),
            Text(
              mapSumarrize(summary),
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                fetchSumarize(conversation, context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              ),
              child: Text(
                summary is AsyncLoading ? 'Generating...' : 'Summarize',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String mapSumarrize(AsyncValue<GenerateContentResponse>? summary) {
    return switch (summary) {
      AsyncData(:final data) => data.text ?? '',
      _ => '',
    };
  }
}

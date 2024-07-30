import 'package:flutter/material.dart';
import 'package:signsyncai/features/auth/domain/account.dart';
import 'package:signsyncai/features/chats/domain/conversation.dart';
import 'package:signsyncai/screens/room_chat.dart';

class ListConversation extends StatelessWidget {
  final Conversation conversation;
  final Account account;

  const ListConversation({
    super.key,
    required this.conversation,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () =>
          Navigator.of(context).push(RoomChat.route(conversation, account)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(
                account.avatar!,
              ),
              radius: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    account.name!,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  Text(
                    conversation.lastMessage,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Text(
              _formatTimestamp(DateTime.now()),
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inDays > 0) {
      return '${difference.inDays}d';
    } else if (difference.inHours > 0) {
      return '${difference.inHours}h';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes}m';
    } else {
      return 'just now';
    }
  }
}

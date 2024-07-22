import 'package:flutter/material.dart';

class ChatRoomHeader extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String userImageUrl;
  final GlobalKey<ScaffoldState> drawerController;

  const ChatRoomHeader({
    super.key,
    required this.userName,
    required this.userImageUrl,
    required this.drawerController,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0x00ededf4),
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back,
          color: Colors.black,
          size: 25,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userImageUrl),
            radius: 16,
          ),
          const SizedBox(width: 10),
          Text(
            userName,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 16,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.attachment, color: Colors.black),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

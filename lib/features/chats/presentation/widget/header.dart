import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ChatRoomHeader extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String userImageUrl;

  const ChatRoomHeader({
    super.key,
    required this.userName,
    required this.userImageUrl,
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
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          CircleAvatar(
            backgroundImage: NetworkImage(userImageUrl),
            radius: 16,
          ),
          const SizedBox(width: 10),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Text(
              userName,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                color: Colors.black,
                fontSize: 16,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const PhosphorIcon(
            PhosphorIconsDuotone.magicWand,
            color: Colors.black,
          ),
          onPressed: () => Scaffold.of(context).openDrawer(),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

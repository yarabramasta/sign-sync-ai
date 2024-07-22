import 'package:flutter/material.dart';

class PaperPlaneButton extends StatelessWidget {
  final VoidCallback onPressed;

  const PaperPlaneButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        margin: const EdgeInsets.only(left: 8),
        decoration: BoxDecoration(
          color: const Color(0xFFFFE5B4),
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.send,
          size: 20,
          color: Color(0xFF996633),
        ),
      ),
    );
  }
}

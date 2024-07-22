import 'package:flutter/material.dart';

class VoiceRecordButton extends StatelessWidget {
  final VoidCallback onPressed;

  const VoiceRecordButton({required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: onPressed,
        child: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.blue[100],
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            Icons.mic,
            size: 20,
            color: Colors.blue[500],
          ),
        ),
      ),
    );
  }
}

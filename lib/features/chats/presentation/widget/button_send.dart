import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

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
          color: Theme.of(context).colorScheme.tertiaryContainer,
          borderRadius: BorderRadius.circular(12),
        ),
        child: PhosphorIcon(
          PhosphorIconsRegular.paperPlaneTilt,
          size: 20,
          color: Theme.of(context).colorScheme.tertiary,
        ),
      ),
    );
  }
}

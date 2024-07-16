import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:signsyncai/ui/utils/sizes.dart';

class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(Sizes.p16),
        child: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Theme.of(context).colorScheme.tertiaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onTertiaryContainer,
          child: const PhosphorIcon(PhosphorIconsDuotone.chatTeardropDots),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(Sizes.p24),
        shrinkWrap: true,
        children: const [
          Text('Hello, World!'),
        ],
      ),
    );
  }
}

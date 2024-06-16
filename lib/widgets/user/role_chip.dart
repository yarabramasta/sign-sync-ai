import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:signsyncai/providers/auth.dart';

class RoleChip extends ConsumerWidget {
  const RoleChip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final role = ref.watch(
      currentUserProvider.select((user) => user.valueOrNull?.role.name),
    );

    return Theme(
      data: Theme.of(context).copyWith(visualDensity: VisualDensity.compact),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          side: BorderSide(color: Theme.of(context).colorScheme.primary),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          foregroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
          padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
        ),
        child: Text(
          role == null ? '' : role[0].toUpperCase() + role.substring(1),
          style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
    );
  }
}

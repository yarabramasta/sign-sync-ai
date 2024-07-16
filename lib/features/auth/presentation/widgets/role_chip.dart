import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:signsyncai/features/auth/presentation/store.dart';

class RoleChip extends RearchConsumer {
  const RoleChip({super.key});

  @override
  Widget build(BuildContext context, WidgetHandle use) {
    final (role, placeholder) = use(role$);
    return Chip(
      visualDensity: VisualDensity.compact,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(99),
        side: BorderSide(color: Theme.of(context).colorScheme.primary),
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      label: Text(
        toBeginningOfSentenceCase(role ?? placeholder),
        style: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Theme.of(context).colorScheme.onPrimaryContainer),
      ),
    );
  }
}

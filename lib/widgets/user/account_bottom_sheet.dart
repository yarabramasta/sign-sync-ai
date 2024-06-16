import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:signsyncai/constants/sizes.dart';
import 'package:signsyncai/models/account.dart';
import 'package:signsyncai/providers/auth.dart';
import 'package:signsyncai/widgets/user/role_chip.dart';

void showAccountBottomSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    builder: (context) => const AccountBottomSheet(),
    showDragHandle: true,
  );
}

class AccountBottomSheet extends ConsumerWidget {
  const AccountBottomSheet({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(currentUserProvider);

    return Card(
      elevation: 0,
      child: user.when(
        data: (account) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            buildAccountTile(context, ref: ref, account: account),
            Padding(
              padding: const EdgeInsets.all(Sizes.p16).copyWith(bottom: 0),
              child: const Divider(),
            ),
            buildLogoutTile(context, ref),
            gapH24,
          ],
        ),
        error: (error, _) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: OutlinedButton(
                onPressed: () => ref.invalidate(authControllerProvider),
                child: const Text('Retry'),
              ),
            ),
          ],
        ),
        loading: () => const Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
          ],
        ),
      ),
    );
  }

  ListTile buildAccountTile(
    BuildContext context, {
    Account? account,
    required WidgetRef ref,
  }) {
    return ListTile(
      dense: true,
      visualDensity: VisualDensity.compact,
      leading: CircleAvatar(
        backgroundImage: NetworkImage(
          account?.avatar ??
              'https://api.dicebear.com/8.x/notionists/svg?seed=johndoe',
        ),
      ),
      title: Text(account?.name ?? ''),
      titleTextStyle: Theme.of(context).textTheme.titleMedium,
      subtitle: AutoSizeText(
        account?.email ?? '',
        maxFontSize: 14,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      isThreeLine: true,
      trailing: const RoleChip(),
    );
  }

  ListTile buildLogoutTile(
    BuildContext context,
    WidgetRef ref,
  ) {
    final auth = ref.watch(authControllerProvider);

    return ListTile(
      onTap: auth.isLoading || auth.valueOrNull == null
          ? null
          : () async {
              await ref
                  .read(authControllerProvider.notifier)
                  .signOut()
                  .then((_) {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                }
              });
            },
      leading: PhosphorIcon(
        PhosphorIconsRegular.signOut,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: const Text('Sign out'),
    );
  }
}

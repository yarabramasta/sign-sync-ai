import 'package:auto_size_text/auto_size_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/features/auth/presentation/store.dart';
import 'package:signsyncai/features/auth/presentation/widgets/role_chip.dart';
import 'package:signsyncai/services/kv.dart';
import 'package:signsyncai/ui/l10n/l10n_bottom_sheet.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

import '../actions.dart';

Future<void> showAccountBottomSheet(BuildContext context) {
  return WoltModalSheet.show(
    context: context,
    useRootNavigator: true,
    useSafeArea: true,
    pageListBuilder: (context) => [
      SliverWoltModalSheetPage(
        hasTopBarLayer: true,
        isTopBarLayerAlwaysVisible: true,
        topBar: ListTile(
          dense: true,
          visualDensity: VisualDensity.compact,
          leading: RearchBuilder(
            builder: (context, use) {
              final (avatar, avatarPlaceholder) = use(avatar$);
              return CircleAvatar(
                backgroundImage: NetworkImage(avatar ?? avatarPlaceholder),
              );
            },
          ),
          title: RearchBuilder(
            builder: (context, use) {
              final (name, namePlaceholder) = use(name$);
              return Text(name ?? namePlaceholder);
            },
          ),
          titleTextStyle: Theme.of(context).textTheme.titleMedium,
          subtitle: RearchBuilder(
            builder: (context, use) {
              final (email, emailPlaceholder) = use(email$);
              return AutoSizeText(
                email ?? emailPlaceholder,
                maxFontSize: 14,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              );
            },
          ),
          isThreeLine: true,
          trailing: const RoleChip(),
        ),
        mainContentSlivers: [
          SliverToBoxAdapter(
            child: ValueListenableBuilder(
              valueListenable: KV.setting.listenable(keys: ['is_dark_mode']),
              builder: (context, box, _) {
                final darkMode = box.get('is_dark_mode') ?? false;
                return ListTile(
                  dense: true,
                  leading: PhosphorIcon(
                    darkMode
                        ? PhosphorIconsRegular.moon
                        : PhosphorIconsRegular.sun,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  title: const Text('Dark Mode'),
                  subtitle: Text(darkMode ? 'On' : 'Off'),
                  trailing: Switch(
                    value: darkMode,
                    onChanged: (value) {
                      box.put('dark_mode', value);
                    },
                  ),
                );
              },
            ),
          ),
          SliverToBoxAdapter(
            child: ListTile(
              title: const Text('Language'),
              subtitle: Text(
                context.locale.languageCode == 'id'
                    ? 'Bahasa Indonesia'
                    : 'English',
              ),
              onTap: () => WoltModalSheet.of(context).showNext(),
            ),
          ),
          SliverToBoxAdapter(
            child: RearchBuilder(
              builder: (context, use) {
                final (state, signout) = use(signoutAction);
                return ListTile(
                  title: const Text('Sign out'),
                  onTap: state is AsyncLoading
                      ? null
                      : () => signout(onData: () => Navigator.pop(context)),
                  leading: PhosphorIcon(
                    PhosphorIconsRegular.signOut,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                );
              },
            ),
          ),
        ],
      ),
      buildL10nBottomSheet(
        context,
        onLocaleChange: (_) => WoltModalSheet.of(context).popPage(),
      ),
    ],
  );
}

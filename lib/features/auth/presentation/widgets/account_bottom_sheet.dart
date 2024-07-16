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
import 'package:signsyncai/ui/utils/sizes.dart';
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
        navBarHeight: 96,
        topBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: Sizes.p24),
          child: ListTile(
            dense: true,
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
                return AutoSizeText(
                  name ?? namePlaceholder,
                  minFontSize: 14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontWeight: FontWeight.w500),
                );
              },
            ),
            titleTextStyle: Theme.of(context).textTheme.titleMedium,
            subtitle: RearchBuilder(
              builder: (context, use) {
                final (email, emailPlaceholder) = use(email$);
                return AutoSizeText(
                  email ?? emailPlaceholder,
                  maxFontSize: 13,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                );
              },
            ),
            isThreeLine: true,
            trailing: const RoleChip(),
          ),
        ),
        mainContentSlivers: [
          SliverPadding(
            padding: const EdgeInsets.all(Sizes.p16),
            sliver: SliverMainAxisGroup(
              slivers: [
                SliverToBoxAdapter(
                  child: ValueListenableBuilder(
                    valueListenable: KV.setting.listenable(
                      keys: ['is_dark_mode'],
                    ),
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
                            box.put('is_dark_mode', value);
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
                    leading: PhosphorIcon(
                      PhosphorIconsRegular.globe,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onTap: () => WoltModalSheet.of(context).pushPage(
                      buildL10nBottomSheet(
                        context,
                        onLocaleChange: (_) {
                          WoltModalSheet.of(context).popPage();
                        },
                      ),
                    ),
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
                            : () => signout(context),
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
          ),
        ],
      ),
    ],
  );
}

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

import 'l10n_bottom_sheet.dart';

class L10nListTile extends StatelessWidget {
  const L10nListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      leading: PhosphorIcon(
        PhosphorIconsRegular.globe,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: const Text('Language'),
      subtitle: Text(context.locale.languageCode.toUpperCase()),
      trailing: PhosphorIcon(
        PhosphorIconsRegular.caretRight,
        color: Theme.of(context).hintColor,
      ),
      onTap: () async {
        await showL10nBottomSheet(context);
      },
    );
  }
}

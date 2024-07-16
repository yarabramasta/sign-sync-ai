import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:wolt_modal_sheet/wolt_modal_sheet.dart';

Future<Locale?> showL10nBottomSheet(BuildContext context) {
  return WoltModalSheet.show<Locale>(
    context: context,
    useRootNavigator: true,
    useSafeArea: true,
    pageListBuilder: (context) => [buildL10nBottomSheet(context)],
  );
}

SliverWoltModalSheetPage buildL10nBottomSheet(
  BuildContext context, {
  void Function(Locale)? onLocaleChange,
}) {
  void handleChange(Locale? val) {
    context.setLocale(val ?? context.deviceLocale);
    onLocaleChange != null
        ? onLocaleChange(val ?? context.deviceLocale)
        : Navigator.pop(context, val);
  }

  return SliverWoltModalSheetPage(
    hasTopBarLayer: true,
    isTopBarLayerAlwaysVisible: true,
    topBarTitle: Text(
      'Choose Language',
      style: Theme.of(context).textTheme.titleMedium,
    ),
    mainContentSlivers: [
      SliverList.list(
        children: [
          RadioListTile(
            title: const Text('Bahasa Indonesia'),
            value: const Locale('id'),
            groupValue: context.locale,
            onChanged: handleChange,
          ),
          RadioListTile(
            title: const Text('English'),
            value: const Locale('en'),
            groupValue: context.locale,
            onChanged: handleChange,
          ),
        ],
      ),
    ],
  );
}

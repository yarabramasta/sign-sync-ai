import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void showL10nBottomSheet(BuildContext context) async {
  await showModalBottomSheet(
    context: context,
    builder: (context) => const L10nRadioBottomSheet(),
    showDragHandle: true,
  );
}

class L10nRadioBottomSheet extends StatelessWidget {
  const L10nRadioBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          RadioListTile(
            value: const Locale('id'),
            groupValue: context.locale,
            title: const Text("Bahasa Indonesia"),
            onChanged: (val) {
              context.setLocale(val ?? const Locale('id'));
              Navigator.of(context).pop();
            },
          ),
          RadioListTile(
            value: const Locale('en'),
            groupValue: context.locale,
            title: const Text("English"),
            onChanged: (val) {
              context.setLocale(val ?? const Locale('en'));
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

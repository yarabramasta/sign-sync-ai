import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              context.pop();
            },
          ),
          RadioListTile(
            value: const Locale('en'),
            groupValue: context.locale,
            title: const Text("English"),
            onChanged: (val) {
              context.setLocale(val ?? const Locale('en'));
              context.pop();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

void showBusyDialog(BuildContext context) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) => const _ModalDialogBusy(),
  );
}

class _ModalDialogBusy extends StatelessWidget {
  const _ModalDialogBusy();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}

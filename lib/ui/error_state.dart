import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:signsyncai/features/auth/presentation/store.dart';
import 'package:signsyncai/ui/utils/sizes.dart';

class ErrorScaffold extends StatelessWidget {
  const ErrorScaffold({super.key, required this.error});

  final dynamic error;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.errorContainer,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              PhosphorIcon(
                PhosphorIconsDuotone.xCircle,
                color: Theme.of(context).colorScheme.onErrorContainer,
              ),
              gapH24,
              Text(
                '$error',
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onErrorContainer),
              ),
              gapH16,
              RearchBuilder(builder: (context, use) {
                final (_, refresh) = use(refreshableAccount);
                return OutlinedButton(
                  onPressed: refresh,
                  child: const Text('Back to home'),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

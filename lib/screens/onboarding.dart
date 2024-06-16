import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:signsyncai/constants/sizes.dart';
import 'package:signsyncai/hooks/use_dark_mode.dart';
import 'package:signsyncai/providers/auth.dart';
import 'package:signsyncai/widgets/l10n_radio_bottom_sheet.dart';
import 'package:websafe_svg/websafe_svg.dart';

class OnboardingScreen extends HookConsumerWidget {
  static MaterialPageRoute get route {
    return MaterialPageRoute(
      builder: (context) => const OnboardingScreen(),
    );
  }

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final controller = usePageController();

    final handlePageChanged = useCallback((int page) {
      controller.animateToPage(
        page,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutExpo,
      );
    }, []);

    useEffect(() {
      final timer = Timer.periodic(
        const Duration(seconds: 10),
        (t) => handlePageChanged(
          (controller.page ?? controller.initialPage).round() == 0 ? 1 : 0,
        ),
      );

      return () => timer.cancel();
    }, [handlePageChanged]);

    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar: buildGoogleAuthButton(context, ref),
      body: buildBody(controller),
    );
  }

  SafeArea buildBody(PageController controller) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: PageView.builder(
              controller: controller,
              itemCount: 2,
              itemBuilder: (context, index) => _OnboardingPage(index: index),
            ),
          )
        ],
      ),
    );
  }

  BottomAppBar buildGoogleAuthButton(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authControllerProvider);

    return BottomAppBar(
      elevation: 0,
      padding: const EdgeInsets.all(Sizes.p16),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: OutlinedButton.icon(
        onPressed: auth.isLoading || auth.valueOrNull != null
            ? null
            : ref.read(authControllerProvider.notifier).signIn,
        icon: WebsafeSvg.asset('assets/images/google.svg', width: 24),
        label: const Text('Continue with Google'),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      scrolledUnderElevation: 0,
      titleSpacing: Sizes.p16,
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          WebsafeSvg.asset('assets/images/signsyncai-icon.svg', width: 24),
          gapW8,
          Text(
            'SignSyncAI',
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ],
      ),
      actions: [
        Image.asset('assets/images/unmer-logo.png', width: 20),
        gapW8,
        Image.asset('assets/images/fti-logo.png', width: 18),
        gapW16,
        Theme(
          data: Theme.of(context).copyWith(
            visualDensity: VisualDensity.compact,
          ),
          child: OutlinedButton.icon(
            onPressed: () => showL10nBottomSheet(context),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: Sizes.p4,
              ),
            ),
            icon: const PhosphorIcon(PhosphorIconsDuotone.globe, size: 16),
            label: Text(
              context.locale.languageCode.toUpperCase(),
              style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ),
        ),
        gapW16
      ],
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(Sizes.p24),
      shrinkWrap: true,
      children: [
        _OnboardingIllustration(name: index == 0 ? "smart_chat" : "bara"),
        Text(
          context.tr(
            "onboarding_screen.${index == 0 ? 'first' : 'second'}_page.title",
          ),
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Theme.of(context).colorScheme.primary),
        ),
        gapH16,
        Text(
          context.tr(
            "onboarding_screen.${index == 0 ? 'first' : 'second'}_page.microcopy",
          ),
          style: Theme.of(context)
              .textTheme
              .bodyMedium
              ?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
        ),
      ],
    );
  }
}

class _OnboardingIllustration extends HookWidget {
  const _OnboardingIllustration({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = useDarkMode().isDarkMode;

    final buildLottie = useCallback(() {
      return Lottie.asset(
        'assets/lottie/${name}_brightness_${isDarkMode ? "dark" : "light"}.json',
        backgroundLoading: true,
      );
    }, [isDarkMode, name]);

    return buildLottie();
  }
}

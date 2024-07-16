import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:lottie/lottie.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/features/auth/presentation/actions.dart';
import 'package:signsyncai/services/kv.dart';
import 'package:signsyncai/ui/l10n/l10n_button.dart';
import 'package:signsyncai/ui/utils/sizes.dart';
import 'package:websafe_svg/websafe_svg.dart';

class OnboardingScreen extends RearchConsumer {
  static MaterialPageRoute get route {
    return MaterialPageRoute(
      builder: (context) => const OnboardingScreen(),
    );
  }

  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetHandle use) {
    final controller = use.pageController();

    use.effect(() {
      final timer = Timer.periodic(
        const Duration(seconds: 10),
        (t) => controller.animateToPage(
          (controller.page ?? controller.initialPage).round() == 0 ? 1 : 0,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeOutExpo,
        ),
      );

      return () => timer.cancel();
    }, [controller]);

    return Scaffold(
      appBar: buildAppBar(context),
      bottomNavigationBar: buildGoogleAuthButton(context),
      body: SafeArea(
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
      ),
    );
  }

  BottomAppBar buildGoogleAuthButton(BuildContext context) {
    return BottomAppBar(
      elevation: 0,
      padding: const EdgeInsets.all(Sizes.p16),
      color: Theme.of(context).scaffoldBackgroundColor,
      child: RearchBuilder(builder: (context, use) {
        final (state, signin) = use(signinAction);
        return OutlinedButton.icon(
          onPressed: state is AsyncLoading ? null : () => signin(),
          icon: WebsafeSvg.asset('assets/images/google.svg', width: 24),
          label: const Text('Continue with Google'),
        );
      }),
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
        const L10nButton(),
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

class _OnboardingIllustration extends RearchConsumer {
  const _OnboardingIllustration({required this.name});

  final String name;

  @override
  Widget build(BuildContext context, WidgetHandle use) {
    final isDarkMode = use.memo(() => KV.setting.get("is_dark_mode") ?? false);
    final buildLottie = use.memo(() {
      return Lottie.asset(
        'assets/lottie/${name}_brightness_${isDarkMode ? "dark" : "light"}.json',
        backgroundLoading: true,
      );
    }, [isDarkMode]);

    return buildLottie;
  }
}

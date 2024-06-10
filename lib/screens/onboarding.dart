import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lottie/lottie.dart';
import 'package:signsyncai/constants/sizes.dart';
import 'package:signsyncai/hooks/use_dark_mode.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends HookWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
        const Duration(seconds: 3),
        (t) => handlePageChanged(
          (controller.page ?? controller.initialPage).round(),
        ),
      );

      return () => timer.cancel();
    }, [handlePageChanged]);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SmoothPageIndicator(
                controller: controller,
                count: 2,
                onDotClicked: handlePageChanged,
                effect: WormEffect(
                  dotColor: Theme.of(context).colorScheme.secondaryContainer,
                  activeDotColor: Theme.of(context).colorScheme.secondary,
                  dotWidth: 8,
                  dotHeight: 8,
                ),
              ),
              FilledButton(
                onPressed: () => handlePageChanged(
                  (controller.page ?? controller.initialPage).round(),
                ),
                child: Text(context.tr("get_started")),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(Sizes.p24),
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
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
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _OnboardingIllustration(name: index == 0 ? "smart_chat" : "bara"),
        Text(
          context.tr(
            "onboarding_screen.${index == 0 ? 'first' : 'second'}_page.title",
          ),
          style: Theme.of(context)
              .textTheme
              .displaySmall
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

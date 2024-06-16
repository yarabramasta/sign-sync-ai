import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';
import 'package:signsyncai/constants/sizes.dart';
import 'package:signsyncai/widgets/user/account_bottom_sheet.dart';
import 'package:websafe_svg/websafe_svg.dart';

import 'bara.dart';
import 'chats.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentPage = useState(0);
    final pageCtrl = usePageController(initialPage: currentPage.value);

    useEffect(() {
      void trackPageChanges() {
        final page = (pageCtrl.page ?? pageCtrl.initialPage).round();
        if (page != currentPage.value) {
          currentPage.value = page;
        }
      }

      pageCtrl.addListener(trackPageChanges);

      return () => pageCtrl.removeListener(trackPageChanges);
    }, [pageCtrl, currentPage]);

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(64),
        child: AppBar(
          scrolledUnderElevation: 0,
          titleSpacing: Sizes.p16,
          title: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              WebsafeSvg.asset('assets/images/signsyncai-icon.svg', width: 32),
              gapW8,
              const Expanded(child: Text('SignSyncAI')),
              gapW24,
            ],
          ),
          actions: [
            const IconButton(
              onPressed: null,
              icon: PhosphorIcon(PhosphorIconsRegular.magnifyingGlass),
            ),
            IconButton(
              onPressed: () => showAccountBottomSheet(context),
              icon: const PhosphorIcon(PhosphorIconsRegular.dotsThreeVertical),
            ),
            gapW8
          ],
        ),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentPage.value,
        onDestinationSelected: (index) {
          pageCtrl.animateToPage(
            index,
            duration: const Duration(milliseconds: 600),
            curve: Curves.easeOutCubic,
          );
        },
        destinations: [
          NavigationDestination(
            label: 'Chat',
            tooltip: 'Chat',
            icon: const PhosphorIcon(PhosphorIconsRegular.chatsTeardrop),
            selectedIcon: PhosphorIcon(
              PhosphorIconsDuotone.chatsTeardrop,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          NavigationDestination(
            label: 'BARA',
            tooltip: 'BARA',
            icon: const PhosphorIcon(PhosphorIconsRegular.cubeFocus),
            selectedIcon: PhosphorIcon(
              PhosphorIconsDuotone.cubeFocus,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: pageCtrl,
                children: const [ChatsScreen(), BaraScreen()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

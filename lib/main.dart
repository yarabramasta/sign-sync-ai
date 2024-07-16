import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rearch/flutter_rearch.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:rearch/rearch.dart';
import 'package:signsyncai/screens/home.dart';
import 'package:signsyncai/ui/error_state.dart';

import 'features/auth/presentation/store.dart';
import 'firebase_options.dart';
import 'screens/onboarding.dart';
import 'services/kv.dart';
import 'ui/splash.dart';
import 'ui/theme/theme.dart';
import 'ui/theme/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await KV.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  GoogleFonts.config.allowRuntimeFetching = false;
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('id')],
      path: 'i18n',
      useOnlyLangCode: true,
      fallbackLocale: const Locale('id'),
      child: const SignSyncAI(),
    ),
  );
}

final navigator = GlobalKey<NavigatorState>();
final messenger = GlobalKey<ScaffoldMessengerState>();

class SignSyncAI extends RearchConsumer {
  const SignSyncAI({super.key});

  @override
  Widget build(BuildContext context, WidgetHandle use) {
    final auth = use(account$);
    final home = use.memo(
      () => switch (auth) {
        AsyncLoading() => const Splash(),
        AsyncError(:final error) => ErrorScaffold(error: error),
        AsyncData(:final data) =>
          data != null ? const HomeScreen() : const OnboardingScreen(),
      },
      [auth],
    );

    use.automaticKeepAlive();

    TextTheme textTheme = createTextTheme(context, 'Inter', 'DM Sans');
    MaterialTheme theme = MaterialTheme(textTheme);

    return ValueListenableBuilder(
      valueListenable: KV.setting.listenable(keys: ['is_dark_mode']),
      builder: (context, box, _) {
        final isDarkMode = (box.get('is_dark_mode') ?? false);
        return MaterialApp(
          title: 'Sign Sync AI',
          debugShowCheckedModeBanner: false,
          navigatorKey: navigator,
          scaffoldMessengerKey: messenger,
          theme: isDarkMode ? theme.dark() : theme.light(),
          darkTheme: theme.dark(),
          themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          home: home,
        );
      },
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:signsyncai/generated/codegen_loader.g.dart';
import 'package:signsyncai/screens/home.dart';
import 'package:signsyncai/widgets/scaffold_busy.dart';

import 'constants/sizes.dart';
import 'firebase_options.dart';
import 'hooks/use_dark_mode.dart';
import 'providers/auth.dart';
import 'screens/onboarding.dart';
import 'services/kv.dart';
import 'theme/theme.dart';
import 'theme/util.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
  );

  await KV.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  GoogleFonts.config.allowRuntimeFetching = false;
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('id')],
        path: 'assets/translations',
        useOnlyLangCode: true,
        fallbackLocale: const Locale('en'),
        assetLoader: const CodegenLoader(),
        child: const SignSyncAI(),
      ),
    ),
  );
}

final navigator = GlobalKey<NavigatorState>();
final messenger = GlobalKey<ScaffoldMessengerState>();

class SignSyncAI extends HookConsumerWidget {
  const SignSyncAI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDarkMode = useDarkMode().isDarkMode;

    TextTheme textTheme = createTextTheme(context, 'Inter', 'DM Sans');
    MaterialTheme materialTheme = MaterialTheme(textTheme);

    SystemChrome.setSystemUIOverlayStyle(
      isDarkMode
          ? SystemUiOverlayStyle.light
              .copyWith(statusBarColor: Colors.transparent)
          : SystemUiOverlayStyle.dark
              .copyWith(statusBarColor: Colors.transparent),
    );

    final auth = ref.watch(currentUserProvider);

    return MaterialApp(
      title: 'SignSyncAI',
      debugShowCheckedModeBanner: false,
      scaffoldMessengerKey: messenger,
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      navigatorKey: navigator,
      home: auth.when(
        loading: () => const ScaffoldBusy(),
        error: (error, _) => _AppError(error: error),
        data: (account) {
          return account != null
              ? const HomeScreen()
              : const OnboardingScreen();
        },
      ),
    );
  }
}

class _AppError extends ConsumerWidget {
  const _AppError({required this.error});

  final Object error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Sizes.p24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('$error'),
            gapH16,
            OutlinedButton(
              onPressed: () {
                ref.invalidate(currentUserProvider);
              },
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:signsyncai/generated/codegen_loader.g.dart';

import 'firebase_options.dart';
import 'hooks/use_dark_mode.dart';
import 'providers/router.dart';
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

final messenger = GlobalKey<ScaffoldMessengerState>();

class SignSyncAI extends HookConsumerWidget {
  const SignSyncAI({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routerConfig = ref.watch(routerProvider);
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

    return MaterialApp.router(
      title: 'SignSyncAI',
      debugShowCheckedModeBanner: false,
      routerConfig: routerConfig,
      scaffoldMessengerKey: messenger,
      theme: materialTheme.light(),
      darkTheme: materialTheme.dark(),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}

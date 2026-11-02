import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/constants/app_colors.dart';
import 'core/lang/app_language.dart';
import 'core/lang/language_helper.dart';
import 'core/lang/translation_service.dart';
import 'features/auth/data/datasources/auth_local_data_source.dart';
import 'features/auth/data/datasources/auth_remote_data_source.dart';
import 'features/auth/data/repositories/auth_repository_impl.dart';
import 'features/auth/login_screen.dart';
import 'features/auth/providers/auth_provider.dart';
import 'features/home/providers/home_provider.dart';
import 'features/navigation/main_navigation.dart';
import 'features/onboarding/onboarding_screen.dart';
import 'features/profile/providers/profile_provider.dart';

void main() async {
  Logger.level = kReleaseMode ? Level.off : Level.debug;
  final binding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: binding);
  await AppLanguage.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => FlutterNativeSplash.remove(),
    );
  }

  @override
  Widget build(BuildContext context) => MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => ProfileProvider()),
      ChangeNotifierProvider<AuthProvider>(
        create: (_) {
          const storage = FlutterSecureStorage();
          return AuthProvider(
            AuthRepositoryImpl(
              AuthRemoteDataSource(http.Client()),
              AuthLocalDataSource(storage),
            ),
          );
        },
      ),
    ],
    child: GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lương Y',
      translations: TranslationService(),
      locale: LanguageHelper.localeForCode(AppLanguage.code.value),
      fallbackLocale: TranslationService.fallbackLocaleVi,
      theme: ThemeData(
        fontFamily: 'NotoSans',
        scaffoldBackgroundColor: AppColors.grayLightColor,
        primarySwatch: Colors.blue,
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: AppColors.primaryColor.withValues(alpha: 0.5),
          cursorColor: AppColors.primaryColor,
        ),
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('vi'), Locale('en'), Locale('zh')],
      home: const AuthGate(),
    ),
  );
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});
  @override
  Widget build(BuildContext context) => FutureBuilder<bool>(
    future: LanguageHelper.isOnboardingCompleted(),
    builder: (context, onboarding) {
      if (onboarding.connectionState != ConnectionState.done) {
        return const _StartupLoading();
      }
      if (!(onboarding.data ?? false)) {
        return const OnboardingScreen();
      }
      return Consumer<AuthProvider>(
        builder: (context, auth, _) {
          if (auth.status == AuthStatus.initializing) {
            return const _StartupLoading();
          }
          return auth.isLoggedIn ? const MainNavigation() : const LoginScreen();
        },
      );
    },
  );
}

class _StartupLoading extends StatelessWidget {
  const _StartupLoading();
  @override
  Widget build(BuildContext context) =>
      const Scaffold(body: Center(child: CircularProgressIndicator()));
}

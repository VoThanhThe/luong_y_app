import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/constants/app_colors.dart';
import 'core/lang/app_language.dart';
import 'core/lang/language_helper.dart';
import 'features/navigation/main_navigation.dart';
import 'features/onboarding/onboarding_screen.dart';

void main() async {
  if (kReleaseMode) {
    Logger.level = Level.off;
  } else {
    Logger.level = Level.debug;
  }

  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

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
    _removeSplash();
  }

  // Gỡ bỏ native splash sau khi app đã chuẩn bị xong frame đầu tiên
  void _removeSplash() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FlutterNativeSplash.remove();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _getLoginStatus(),
      builder: (context, loginSnapshot) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lương Y',
          theme: ThemeData(
            fontFamily: 'Itim',
            scaffoldBackgroundColor: AppColors.grayLightColor,
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
            textSelectionTheme: TextSelectionThemeData(
              selectionColor: AppColors.primaryColor.withValues(
                alpha: 0.5,
              ),
              cursorColor: AppColors.primaryColor,
            ),
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [Locale('vi'), Locale('en'), Locale('zh')],
          home: FutureBuilder<bool>(
            future: LanguageHelper.isOnboardingCompleted(),
            builder: (context, onboardingSnapshot) {
              if (onboardingSnapshot.connectionState == ConnectionState.waiting) {
                // Trong lúc chờ check dữ liệu, để màn hình trống trùng màu background
                return const Scaffold(
                  body: SizedBox.shrink(),
                );
              }

              bool isCompleted = onboardingSnapshot.data ?? false;

              // Đảo lại logic cho đúng: Chưa xong hiện Onboarding, xong rồi vào MainNavigation
              if (!isCompleted) {
                return const MainNavigation();
                // return const OnboardingScreen();
              } else {
                return const MainNavigation();
              }
            },
          ),
        );
      },
    );
  }

  Future<bool> _getLoginStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ?? false;
  }
}

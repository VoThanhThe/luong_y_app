import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:luong_y_app/features/home/home_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/constants/app_colors.dart';
import 'core/lang/language_helper.dart';
import 'features/navigation/main_navigation.dart';
import 'features/onboarding/onboarding_screen.dart';

void main() async {
  if (kReleaseMode) {
    Logger.level = Level.off;
  } else {
    Logger.level = Level.debug;
  }

  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _getLoginStatus(),
      builder: (context, snapshot) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Lương Y',
          theme: ThemeData(
            fontFamily: 'Itim',
            scaffoldBackgroundColor: AppColors.grayLightColor,
            primarySwatch: Colors.blue,
            textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
            textSelectionTheme: TextSelectionThemeData(
              selectionColor:
                  AppColors.primaryColor.withOpacity(0.5), // Màu nền khi chọn văn bản
              cursorColor: AppColors.primaryColor,
            ),
          ),
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          // locale: initialLocale,
          // translations: TranslationService(),
          fallbackLocale: const Locale('vi'),
          supportedLocales: const [
            Locale('vi'),
            Locale('en'),
            Locale('zh'),
          ],
          home: FutureBuilder<bool>(
            future: LanguageHelper.isOnboardingCompleted(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                    body: Center(child: CircularProgressIndicator()));
              }

              bool isCompleted = snapshot.data ?? false;

              // return const TestAdsScreen();

              if (isCompleted) {
                return const MainNavigation();
              } else {
                return const OnboardingScreen();
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

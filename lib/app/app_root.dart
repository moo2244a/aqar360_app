import 'package:aqar360/app/config/theme/app_theme.dart';
import 'package:aqar360/app/features/onboarding/presentation/pages/welcome_screen.dart';
import 'package:flutter/material.dart';

class AppRoot extends StatelessWidget {
  const AppRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: Locale('ar'),
      debugShowCheckedModeBanner: false,
      title: 'aqar360',

      themeMode: ThemeMode.light,
      theme: AppTheme.lightTheme,
      home: WelcomeScreen(),
    );
  }
}

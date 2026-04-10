import 'package:flutter/material.dart';

import 'features/splash/splash_screen.dart';

class SaarthiApp extends StatelessWidget {
  const SaarthiApp({super.key});

  @override
  Widget build(BuildContext context) {
    const baseColor = Color(0xFFFAF9F5);
    const primary = Color(0xFF1E1A16);
    const accent = Color.fromRGBO(130, 38, 229, 1);
    const soft = Color.fromARGB(255, 220, 210, 233);

    return MaterialApp(
      title: 'Saarthi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: baseColor,
        colorScheme: const ColorScheme.light(
          primary: primary,
          secondary: accent,
          surface: baseColor,
        ),
        textTheme: const TextTheme(
          displaySmall: TextStyle(
            fontSize: 30,
            height: 1.2,
            fontWeight: FontWeight.w600,
            color: primary,
          ),
          titleLarge: TextStyle(
            fontSize: 20,
            height: 1.3,
            fontWeight: FontWeight.w600,
            color: primary,
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            height: 1.5,
            color: primary,
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            height: 1.5,
            color: primary,
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: soft,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          hintStyle: const TextStyle(color: Color(0xFF6B5E52)),
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

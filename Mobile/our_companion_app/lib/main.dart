import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/features/auth/splash/presentation/pages/splash_screen.dart';
import 'package:our_companion_app/core/providers/theme_provider.dart';
import 'package:our_companion_app/core/constents/app_color.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      themeMode: themeMode,
      theme: ThemeData(
        scaffoldBackgroundColor: lightColors.background,
        colorScheme: ColorScheme.fromSeed(seedColor: lightColors.primary),
      ),
      darkTheme: ThemeData(
        scaffoldBackgroundColor: darkColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: darkColors.primary,
          brightness: Brightness.dark,
        ),
      ),
    );
  }
}

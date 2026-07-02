import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:our_companion_app/core/providers/theme_provider.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/routes/app_router.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      routerConfig: router,
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

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 3), () {
      context.go(AppRoutes.roleSelect);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appColors = ref.watch(appColorsProvider);
    return Scaffold(
      backgroundColor: appColors.primary,
      body: Center(child: Text('data')),
    );
  }
}

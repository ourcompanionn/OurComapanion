import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/core/providers/core_provider.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLogin();
  }

  Future<void> _checkLogin()async{
    await Future.delayed(const Duration(seconds: 3));

    final storage =  ref.read(secureStorageProvider);
    final token = await storage.getAccessToken();
    final role = await storage.getUserRole();


   if(!mounted) return;

   if(token == null || token.isEmpty){
    context.go(AppRoutes.roleSelect);
   }else if (role == "customer"){
      context.go(AppRoutes.customerMain);
   }else if (role == "worker"){
    context.go(AppRoutes.workerMain);
   }else{
    context.go(AppRoutes.roleSelect);
   }

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

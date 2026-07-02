import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:our_companion_app/core/routes/app_routes.dart';
import 'package:our_companion_app/features/splash/presentation/pages/splash_screen.dart';
import 'package:our_companion_app/features/onboarding/presentation/pages/role_select_page.dart';
import 'package:our_companion_app/features/auth/presentation/pages/signup_page.dart';
import 'package:our_companion_app/features/auth/presentation/pages/login_page.dart';
import 'package:our_companion_app/features/onboarding/presentation/pages/profile_setup_page.dart';
import 'package:our_companion_app/features/onboarding/presentation/pages/worker_category_page.dart';
import 'package:our_companion_app/customerside/features/home_page/presentation/customer_main_page.dart';
import 'package:our_companion_app/workerside/home_page/presentation/pages/worker_main_page.dart';

final goRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.roleSelect,
        builder: (context, state) => const RoleSelectPage(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupPage(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.profileSetup,
        builder: (context, state) => const ProfileSetupPage(),
      ),
      GoRoute(
        path: AppRoutes.workerCategory,
        builder: (context, state) => const WorkerCategoryPage(),
      ),
      GoRoute(
        path: AppRoutes.customerMain,
        builder: (context, state) => const CustomerMainPage(),
      ),
      GoRoute(
        path: AppRoutes.workerMain,
        builder: (context, state) => const WorkerMainPage(),
      ),
    ],
  );
});

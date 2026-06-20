import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/features/worker/home_page/presentation/pages/worker_home_page.dart';
import 'package:our_companion_app/features/worker/service_page/presentation/pages/worker_service_page.dart';
import 'package:our_companion_app/features/worker/activity_page/presentation/pages/worker_activity_page.dart';
import 'package:our_companion_app/features/worker/profile_page/presentation/pages/worker_profile_page.dart';
import 'package:our_companion_app/shared/widgets/custom_nav_bar.dart';

class WorkerMainPage extends ConsumerStatefulWidget {
  const WorkerMainPage({super.key});

  @override
  ConsumerState<WorkerMainPage> createState() => _WorkerMainPageState();
}

class _WorkerMainPageState extends ConsumerState<WorkerMainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    WorkerHomePage(),
    WorkerServicePage(),
    WorkerActivityPage(),
    WorkerProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final appColors = ref.watch(appColorsProvider);
    return Scaffold(
      backgroundColor: appColors.background,
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomNavBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}

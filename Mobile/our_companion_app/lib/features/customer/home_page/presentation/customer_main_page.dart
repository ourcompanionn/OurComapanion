import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:our_companion_app/core/constents/app_color.dart';
import 'package:our_companion_app/features/customer/home_page/presentation/customer_home_page.dart';
import 'package:our_companion_app/features/customer/service_page/presentation/pages/customer_service_page.dart';
import 'package:our_companion_app/features/customer/activity_page/presentation/customer_activity_page.dart';
import 'package:our_companion_app/features/customer/profile_page/presentation/customer_profile_page.dart';
import 'package:our_companion_app/shared/widgets/custom_nav_bar.dart';

class CustomerMainPage extends ConsumerStatefulWidget {
  const CustomerMainPage({super.key});

  @override
  ConsumerState<CustomerMainPage> createState() => _CustomerMainPageState();
}

class _CustomerMainPageState extends ConsumerState<CustomerMainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = const [
    CustomerHomePage(),
    CustomerServicePage(),
    CustomerActivityPage(),
    CustomerProfilePage(),
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

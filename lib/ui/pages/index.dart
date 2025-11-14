import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: child,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.white,
            currentIndex: _calculateSelectedIndex(context),
            onTap: (int idx) => _onItemTapped(idx, context),
            items: [
          BottomNavigationBarItem(activeIcon: Icon(Icons.home_rounded),icon: Icon(Icons.home_outlined), label: '首页'),
          BottomNavigationBarItem(activeIcon: Icon(Icons.people_alt_rounded),icon: Icon(Icons.people_alt_outlined), label: '联系人'),
          BottomNavigationBarItem(activeIcon: Icon(Icons.person_rounded),icon: Icon(Icons.person_outline_rounded), label: '我'),
        ]));
  }

  static int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) {
      return 0;
    }
    if (location.startsWith('/contact')) {
      return 1;
    }
    if (location.startsWith('/me')) {
      return 2;
    }
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        GoRouter.of(context).go('/home');
      case 1:
        GoRouter.of(context).go('/contact');
      case 2:
        GoRouter.of(context).go('/me');
    }
  }
}

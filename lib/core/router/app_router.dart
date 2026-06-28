import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../presentation/pages/calculator_page.dart';
import '../../presentation/pages/history_page.dart';

class AppRouter {
  static const String calculator = '/';
  static const String history = '/history';

  static final GoRouter router = GoRouter(
    initialLocation: calculator,
    routes: [
      GoRoute(
        path: calculator,
        name: 'calculator',
        pageBuilder: (context, state) => const MaterialPage(
          child: CalculatorPage(),
        ),
      ),
      GoRoute(
        path: history,
        name: 'history',
        pageBuilder: (context, state) => const MaterialPage(
          child: HistoryPage(),
        ),
      ),
    ],
  );
}
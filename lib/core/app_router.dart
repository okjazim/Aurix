import 'package:go_router/go_router.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/register_screen.dart';
import '../features/dashboard/screens/dashboard_screen.dart';
import '../features/trade/screens/buy_gold_screen.dart';
import '../features/trade/screens/sell_gold_screen.dart';
import '../features/history/screens/history_screen.dart';

class AppRouter {
  static GoRouter getRouter(String initialLocation) {
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const DashboardScreen(),
        ),
        GoRoute(
          path: '/buy',
          builder: (context, state) => const BuyGoldScreen(),
        ),
        GoRoute(
          path: '/sell',
          builder: (context, state) => const SellGoldScreen(),
        ),
        GoRoute(
          path: '/history',
          builder: (context, state) => const HistoryScreen(),
        ),
      ],
    );
  }
}
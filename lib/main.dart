import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/app_router.dart';
import 'core/constants/app_colors.dart'; 
import 'services/storage_service.dart';

void main() async {
  // Required for accessing SharedPreferences before runApp
  WidgetsFlutterBinding.ensureInitialized();
  
  final storage = StorageService();
  final bool loggedIn = await storage.isLoggedIn();

  runApp(
    ProviderScope(
      child: AurixApp(startPath: loggedIn ? '/' : '/login'),
    ),
  );
}

class AurixApp extends StatelessWidget {
  final String startPath;
  const AurixApp({super.key, required this.startPath});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Aurix',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.backgroundNavy, // Import used here
        primaryColor: AppColors.primaryGold,
      ),
      routerConfig: AppRouter.getRouter(startPath),
    );
  }
}
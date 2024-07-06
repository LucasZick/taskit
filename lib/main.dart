import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taskit/app_theme.dart';
import 'package:taskit/firebase_options.dart';
import 'package:taskit/providers/configs_provider.dart';
import 'package:taskit/providers/tasks_provider.dart';
import 'package:taskit/providers/user_data_provider.dart';
import 'package:taskit/services/auth_service.dart';
import 'package:taskit/utils/app_routes.dart';
import 'package:taskit/routes.dart';

void main() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        ListenableProvider<ConfigsProvider>(create: (_) => ConfigsProvider()),
        ListenableProvider<UserDataProvider>(create: (_) => UserDataProvider()),
        ListenableProvider<TasksProvider>(create: (_) => TasksProvider()),
      ],
      child: Consumer<ConfigsProvider>(
        builder: (ctx, notifier, child) {
          return MaterialApp(
            title: 'Taskit',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: notifier.isDark ? ThemeMode.dark : ThemeMode.light,
            initialRoute: AppRoutes.openingScreen,
            routes: routes,
          );
        },
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oil_shop_management/injection_container.dart' as di;
import 'package:oil_shop_management/core/routes/app_routes.dart';
import 'package:oil_shop_management/core/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init(); // Dependency injection
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Oil Shop Manager',
      theme: AppTheme.lightTheme,
      initialRoute: AppRoutes.dashboard,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:proximity_service/core/constants/routes.dart';
import 'package:proximity_service/config/routes/app_router.dart';
import 'package:proximity_service/config/theme/theme.dart';
import 'package:proximity_service/injection_container.dart';

void main() async {
// Initialize dependencies
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Proximity Service",
      debugShowCheckedModeBanner: false,
      onGenerateRoute: AppRouter.generateRoute,
      theme: AppTheme.lightTheme,
      initialRoute: RouteConstants.home,
    );
  }
}

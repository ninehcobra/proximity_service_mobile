import 'package:flutter/material.dart';
import 'package:proximity_service/core/constants/routes.dart';
import 'package:proximity_service/config/routes/app_router.dart';
import 'package:proximity_service/config/theme/theme.dart';

void main() {
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

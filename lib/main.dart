import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proximity_service/core/constants/routes.dart';
import 'package:proximity_service/config/routes/app_router.dart';
import 'package:proximity_service/config/theme/theme.dart';
import 'package:proximity_service/features/near_by/presentation/bloc/place/remote/remote_place_bloc.dart';
import 'package:proximity_service/features/near_by/presentation/bloc/place/remote/remote_place_event.dart';

import 'package:proximity_service/injection_container.dart';

void main() async {
// Initialize dependencies
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemotePlaceBloc>(
          create: (context) => sl<RemotePlaceBloc>()..add(const GetPlaces()),
        ),
        // BlocProvider<LocalCurrentPositionBloc>(
        //   create: (context) => sl<LocalCurrentPositionBloc>(),
        // ),
      ],
      child: MaterialApp(
        title: "Proximity Service",
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generateRoute,
        theme: AppTheme.lightTheme,
        initialRoute: RouteConstants.home,
      ),
    );
  }
}

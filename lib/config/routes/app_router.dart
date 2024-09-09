import 'package:proximity_service/core/constants/routes.dart';
import 'package:proximity_service/common_libs.dart';
import 'package:proximity_service/features/near_by/presentation/pages/map_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.home:
        return MaterialPageRoute(
            builder: (_) => const PopScope(
                  canPop: false,
                  child: MapView(),
                ));

      default:
        return MaterialPageRoute(
          builder: (_) => PopScope(
            canPop: false,
            child: Scaffold(
              body:
                  Center(child: Text('No route defined for ${settings.name}')),
            ),
          ),
        );
    }
  }
}

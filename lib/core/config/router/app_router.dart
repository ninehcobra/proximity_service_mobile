import 'package:proximity_service/common/constants/routes.dart';
import 'package:proximity_service/common_libs.dart';
import 'package:proximity_service/presentation/home/pages/map.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteConstants.home:
        return MaterialPageRoute(
            builder: (_) => const PopScope(
                  canPop: false,
                  child: MapPage(),
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

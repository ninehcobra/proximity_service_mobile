import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:proximity_service/common_libs.dart';
import 'package:proximity_service/core/constants/common.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  final MapController _mapController = MapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FlutterMap(
            mapController: _mapController,
            options: MapOptions(
              initialCenter: LatLng(CommonConstants.initialLocation[0],
                  CommonConstants.initialLocation[1]),
              initialZoom: CommonConstants.initialZoom,
            ),
            children: [
              TileLayer(
                urlTemplate: CommonConstants.openStreetMapUrl,
              ),
              // BlocBuilder<LocalCurrentPositionBloc, LocalCurrentPositionState>(
              //     builder: (_, state) {
              //   if (state is LocalCurrentPositionLoading) {
              //     return const Center(child: CircularProgressIndicator());
              //   }
              //   return const SizedBox();
              // })
            ],
          )
        ],
      ),
    );
  }
}

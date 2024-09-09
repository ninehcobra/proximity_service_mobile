import 'dart:io';

import 'package:geolocator/geolocator.dart';
import 'package:geolocator_platform_interface/src/models/position.dart';
import 'package:proximity_service/core/resources/data_state.dart';
import 'package:proximity_service/features/near_by/data/data_sources/remote/near_by_api_service.dart';
import 'package:proximity_service/features/near_by/data/models/place.dart';
import 'package:proximity_service/features/near_by/domain/repository/place_repository.dart';
import 'package:dio/dio.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  late final NearByApiService _nearByApiService;
  PlaceRepositoryImpl(this._nearByApiService);

  @override
  Future<DataState<List<PlaceModel>>> getPlaces() async {
    print('hi');
    try {
      final httpResponse = await _nearByApiService.findNearby(
          latitude: 10.762622, longitude: 106.660172, radius: 10);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
        print(httpResponse.data);
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            type: DioExceptionType.badResponse,
            requestOptions: httpResponse.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataFailed(e);
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }
      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }
    return await Geolocator.getCurrentPosition();
  }

  @override
  Future<DataState<Position>> getCurrentLocation() async {
    try {
      Position position = await _determinePosition();
      return DataSuccess(position);
    } catch (e) {
      return DataFailed(DioException(
        error: e.toString(),
        type: DioExceptionType.unknown,
        requestOptions: RequestOptions(),
      ));
    }
  }
}

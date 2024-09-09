import 'dart:io';

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
    try {
      final httpResponse = await _nearByApiService.findNearby(
          latitude: 10.762622, longitude: 106.660172, radius: 10);

      if (httpResponse.response.statusCode == HttpStatus.ok) {
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
}

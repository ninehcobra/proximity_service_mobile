import 'package:proximity_service/core/constants/common.dart';
import 'package:proximity_service/features/near_by/data/models/place.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

part 'near_by_api_service.g.dart';

@RestApi(baseUrl: CommonConstants.baseApiUrl)
abstract class NearByApiService {
  factory NearByApiService(Dio dio) = _NearByApiService;

  @GET("/find-nearby")
  Future<HttpResponse<List<PlaceModel>>> findNearby({
    @Query("offset") int? offset,
    @Query('limit') int? limit,
    @Query('q') String? query,
    @Query('latitude') double latitude,
    @Query('longitude') double longitude,
    @Query('radius') int radius,
    @Query('isHighRating') bool? isHighRating,
    @Query('openTime') String? openTime,
    @Query('star') int? star,
    @Query('categoryId') String? categoryId,
    @Query('isNearest') bool? isNearest,
  });
}

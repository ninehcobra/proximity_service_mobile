import 'package:proximity_service/core/resources/data_state.dart';
import 'package:proximity_service/features/near_by/domain/entities/place.dart';

abstract class PlaceRepository {
  Future<DataState<List<PlaceEntity>>> getPlaces();
}

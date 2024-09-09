import 'package:proximity_service/core/resources/data_state.dart';
import 'package:proximity_service/features/near_by/data/models/place.dart';
import 'package:proximity_service/features/near_by/domain/repository/place_repository.dart';

class PlaceRepositoryImpl implements PlaceRepository {
  @override
  Future<DataState<List<PlaceModel>>> getPlaces() {
    throw UnimplementedError();
  }
}

import 'package:proximity_service/core/resources/data_state.dart';
import 'package:proximity_service/core/usecases/usecase.dart';
import 'package:proximity_service/features/near_by/domain/entities/place.dart';
import 'package:proximity_service/features/near_by/domain/repository/place_repository.dart';

class FindNearbyUseCase implements Usecase<DataState<List<PlaceEntity>>, void> {
  late final PlaceRepository _placeRepository;
  FindNearbyUseCase(this._placeRepository);

  @override
  Future<DataState<List<PlaceEntity>>> call(void params) {
    return _placeRepository.getPlaces();
  }
}

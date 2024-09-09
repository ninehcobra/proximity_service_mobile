import 'package:geolocator/geolocator.dart';
import 'package:proximity_service/core/resources/data_state.dart';
import 'package:proximity_service/core/usecases/usecase.dart';
import 'package:proximity_service/features/near_by/domain/repository/place_repository.dart';

class GetCurrentLocationUseCase implements Usecase<DataState<Position>, void> {
  final PlaceRepository _placeRepository;

  GetCurrentLocationUseCase(this._placeRepository);

  @override
  Future<DataState<Position>> call(void params) async {
    return _placeRepository.getCurrentLocation();
  }
}

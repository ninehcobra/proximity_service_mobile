import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proximity_service/core/resources/data_state.dart';
import 'package:proximity_service/features/near_by/domain/usecases/find_nearby.dart';
import 'package:proximity_service/features/near_by/presentation/bloc/place/remote/remote_place_event.dart';
import 'package:proximity_service/features/near_by/presentation/bloc/place/remote/remote_place_state.dart';

class RemotePlaceBloc extends Bloc<RemotePlaceEvent, RemotePlaceState> {
  // ignore: unused_field
  final FindNearbyUseCase _findNearbyUseCase;
  RemotePlaceBloc(this._findNearbyUseCase) : super(RemotePlaceLoading()) {
    on<GetPlaces>(onGetPlaces);
  }

  void onGetPlaces(GetPlaces event, Emitter<RemotePlaceState> emit) async {
    final dataState = await _findNearbyUseCase(event);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(RemotePlaceLoaded(places: dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(RemotePlaceError(error: dataState.error!));
    }
  }
}

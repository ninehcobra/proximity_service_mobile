import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proximity_service/core/resources/data_state.dart';
import 'package:proximity_service/features/near_by/domain/usecases/get_current_location.dart';
import 'package:proximity_service/features/near_by/presentation/bloc/current_position/local/local_current_position_event.dart';
import 'package:proximity_service/features/near_by/presentation/bloc/current_position/local/local_current_position_state.dart';

class LocalCurrentPositionBloc
    extends Bloc<LocalCurrentPositionEvent, LocalCurrentPositionState> {
  final GetCurrentLocationUseCase _getCurrentPositionUseCase;

  LocalCurrentPositionBloc(this._getCurrentPositionUseCase)
      : super(const LocalCurrentPositionLoading());

  void onGetCurrentPosition(
      GetCurrentPosition event, Emitter<LocalCurrentPositionState> emit) async {
    final dataState = await _getCurrentPositionUseCase(event);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(LocalCurrentPositionLoaded(position: dataState.data!));
    }

    if (dataState is DataFailed) {
      emit(LocalCurrentPositionError(error: dataState.error!));
    }
  }
}

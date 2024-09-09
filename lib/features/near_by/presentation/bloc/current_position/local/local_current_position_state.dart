import 'package:geolocator/geolocator.dart';
import 'package:dio/dio.dart';

abstract class LocalCurrentPositionState {
  final Position? position;
  final DioException? error;

  const LocalCurrentPositionState({this.position, this.error});
}

class LocalCurrentPositionLoading extends LocalCurrentPositionState {
  const LocalCurrentPositionLoading();
}

class LocalCurrentPositionLoaded extends LocalCurrentPositionState {
  const LocalCurrentPositionLoaded({required Position position})
      : super(position: position);
}

class LocalCurrentPositionError extends LocalCurrentPositionState {
  const LocalCurrentPositionError({required DioException error})
      : super(position: null);
}

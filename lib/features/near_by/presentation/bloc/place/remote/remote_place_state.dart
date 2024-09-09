import 'package:equatable/equatable.dart';
import 'package:proximity_service/features/near_by/domain/entities/place.dart';
import 'package:dio/dio.dart';

abstract class RemotePlaceState extends Equatable {
  final List<PlaceEntity>? places;
  final DioException? error;

  const RemotePlaceState({this.places, this.error});

  @override
  List<Object?> get props => [places, error];
}

class RemotePlaceLoading extends RemotePlaceState {}

class RemotePlaceLoaded extends RemotePlaceState {
  const RemotePlaceLoaded({required List<PlaceEntity> places})
      : super(places: places);
}

class RemotePlaceError extends RemotePlaceState {
  const RemotePlaceError({required DioException error}) : super(error: error);
}

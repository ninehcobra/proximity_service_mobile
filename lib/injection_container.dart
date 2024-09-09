import 'package:get_it/get_it.dart';
import 'package:proximity_service/features/near_by/data/data_sources/remote/near_by_api_service.dart';
import 'package:dio/dio.dart';
import 'package:proximity_service/features/near_by/data/repository/place_repository_impl.dart';
import 'package:proximity_service/features/near_by/domain/repository/place_repository.dart';
import 'package:proximity_service/features/near_by/domain/usecases/find_nearby.dart';
import 'package:proximity_service/features/near_by/presentation/bloc/place/remote/remote_place_bloc.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  print("initializing dependencies that ne");

  print("initializing dependencies that ne");
  // Dio
  sl.registerSingleton<Dio>(Dio());

  // Dependencies
  sl.registerSingleton<NearByApiService>(NearByApiService(sl()));

  sl.registerSingleton<PlaceRepository>(PlaceRepositoryImpl(sl()));

  // Use cases
  sl.registerSingleton<FindNearbyUseCase>(FindNearbyUseCase(sl()));

  // Blocs
  sl.registerFactory<RemotePlaceBloc>(() => RemotePlaceBloc(sl()));

  // sl.registerSingleton(() => LocalCurrentPositionBloc(sl()));
}

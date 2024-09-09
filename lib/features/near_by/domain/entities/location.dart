import 'package:equatable/equatable.dart';

class LocationEntity extends Equatable {
  final List<double> coordinates;
  final String type;

  const LocationEntity({
    required this.coordinates,
    required this.type,
  });

  @override
  List<Object?> get props => [coordinates, type];
}

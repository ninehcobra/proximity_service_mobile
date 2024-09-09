import 'package:equatable/equatable.dart';

class ServiceEntity extends Equatable {
  final String name;
  final String description;
  final int order;
  final String id;

  const ServiceEntity({
    required this.name,
    required this.description,
    required this.order,
    required this.id,
  });

  @override
  List<Object?> get props => [name, description, order, id];
}

import 'package:equatable/equatable.dart';

class CategoryEntity extends Equatable {
  final String name;
  final String linkURL;
  final String id;

  const CategoryEntity({
    required this.name,
    required this.linkURL,
    required this.id,
  });

  @override
  List<Object?> get props => [name, linkURL, id];
}

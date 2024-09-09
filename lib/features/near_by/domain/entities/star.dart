import 'package:equatable/equatable.dart';

class StarEntity extends Equatable {
  final String star;
  final int count;

  const StarEntity({
    required this.star,
    required this.count,
  });

  @override
  List<Object?> get props => [star, count];
}

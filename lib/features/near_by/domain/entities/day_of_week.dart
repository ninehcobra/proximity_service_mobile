import 'package:equatable/equatable.dart';

class DayOfWeekEntity extends Equatable {
  final String day;
  final String openTime;
  final String closeTime;
  final int order;

  const DayOfWeekEntity({
    required this.day,
    required this.openTime,
    required this.closeTime,
    required this.order,
  });

  @override
  List<Object?> get props => [day, openTime, closeTime, order];
}

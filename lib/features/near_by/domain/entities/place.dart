import 'package:equatable/equatable.dart';
import 'package:proximity_service/features/near_by/domain/entities/category.dart';
import 'package:proximity_service/features/near_by/domain/entities/day_of_week.dart';
import 'package:proximity_service/features/near_by/domain/entities/image.dart';
import 'package:proximity_service/features/near_by/domain/entities/location.dart';
import 'package:proximity_service/features/near_by/domain/entities/service.dart';
import 'package:proximity_service/features/near_by/domain/entities/star.dart';

class PlaceEntity extends Equatable {
  final String id;
  final String name;
  final String description;
  final String phoneNumber;
  final String website;
  final CategoryEntity category;
  final List<ServiceEntity> services;
  final double overallRating;
  final int totalReview;
  final String addressLine;
  final String fullAddress;
  final String province;
  final String district;
  final String country;
  final List<DayOfWeekEntity> dayOfWeek;
  final LocationEntity location;
  final List<ImageEntity> images;
  final List<StarEntity> stars;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final double score;
  final double distance;

  const PlaceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.phoneNumber,
    required this.website,
    required this.category,
    required this.services,
    required this.overallRating,
    required this.totalReview,
    required this.addressLine,
    required this.fullAddress,
    required this.province,
    required this.district,
    required this.country,
    required this.dayOfWeek,
    required this.location,
    required this.images,
    required this.stars,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    required this.score,
    required this.distance,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        description,
        phoneNumber,
        website,
        category,
        services,
        overallRating,
        totalReview,
        addressLine,
        fullAddress,
        province,
        district,
        country,
        dayOfWeek,
        location,
        images,
        stars,
        createdAt,
        updatedAt,
        deletedAt,
        score,
        distance,
      ];
}

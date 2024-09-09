import 'package:proximity_service/features/near_by/domain/entities/place.dart';

class PlaceModel extends PlaceEntity {
  const PlaceModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.phoneNumber,
      required super.website,
      required super.category,
      required super.services,
      required super.overallRating,
      required super.totalReview,
      required super.addressLine,
      required super.fullAddress,
      required super.province,
      required super.district,
      required super.country,
      required super.dayOfWeek,
      required super.location,
      required super.images,
      required super.stars,
      required super.createdAt,
      required super.updatedAt,
      required super.score,
      required super.distance});

  factory PlaceModel.fromJson(Map<String, dynamic> map) {
    return PlaceModel(
      id: map['id'],
      name: map['name'],
      description: map['description'],
      phoneNumber: map['phoneNumber'],
      website: map['website'],
      category: map['category'],
      services: map['services'],
      overallRating: map['overallRating'],
      totalReview: map['totalReview'],
      addressLine: map['addressLine'],
      fullAddress: map['fullAddress'],
      province: map['province'],
      district: map['district'],
      country: map['country'],
      dayOfWeek: map['dayOfWeek'],
      location: map['location'],
      images: map['images'],
      stars: map['stars'],
      createdAt: map['createdAt'],
      updatedAt: map['updatedAt'],
      score: map['score'],
      distance: map['distance'],
    );
  }
}

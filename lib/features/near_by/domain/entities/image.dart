import 'package:equatable/equatable.dart';

class ImageEntity extends Equatable {
  final String url;
  final String publicId;
  final String etag;
  final String phash;

  const ImageEntity({
    required this.url,
    required this.publicId,
    required this.etag,
    required this.phash,
  });

  @override
  List<Object?> get props => [url, publicId, etag, phash];
}

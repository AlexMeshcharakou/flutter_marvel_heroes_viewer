import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String description;
  final String? smallThumbnailUrl;
  final String? bigThumbnailUrl;

  const Character({
    required this.id,
    required this.name,
    required this.description,
    this.smallThumbnailUrl,
    this.bigThumbnailUrl,
  });

  @override
  List<Object?> get props => [id, name, description, smallThumbnailUrl, bigThumbnailUrl];
}

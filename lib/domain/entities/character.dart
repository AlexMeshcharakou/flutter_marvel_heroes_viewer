import 'package:equatable/equatable.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String description;
  final String thumbnailPath;
  final String thumbnailExtension;

  const Character({
    required this.id,
    required this.name,
    required this.description,
    required this.thumbnailPath,
    required this.thumbnailExtension,
  });

  @override
  List<Object?> get props => [id, name, description, thumbnailPath, thumbnailExtension];
}

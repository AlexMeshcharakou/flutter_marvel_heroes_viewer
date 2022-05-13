import 'package:equatable/equatable.dart';

class Series extends Equatable {
  final String title;
  final String thumbnailPath;
  final String thumbnailExtension;

  const Series({required this.thumbnailPath, required this.thumbnailExtension, required this.title});

  @override
  List<Object?> get props => [title, thumbnailPath, thumbnailExtension];
}

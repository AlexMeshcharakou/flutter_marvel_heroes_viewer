import 'package:equatable/equatable.dart';

class Series extends Equatable {
  final String title;
  final String thumbnailUrl;

  const Series({required this.title, required this.thumbnailUrl});

  @override
  List<Object?> get props => [title, thumbnailUrl];
}

import 'package:marvel/domain/entities/series.dart';
import 'package:marvel/domain/repository/marvel_repository.dart';

class GetAllSeriesUseCase {
  final MarvelRepository marvelRepository;

  GetAllSeriesUseCase({required this.marvelRepository});

  Future<List<Series>> call(characterId) {
    return marvelRepository.getAllSeries(characterId);
  }
}

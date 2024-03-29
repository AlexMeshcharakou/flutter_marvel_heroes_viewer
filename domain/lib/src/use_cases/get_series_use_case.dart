import 'package:domain/domain_module.dart';

class GetAllSeriesUseCase {
  final MarvelRepository marvelRepository;

  GetAllSeriesUseCase({required this.marvelRepository});

  Future<List<Series>> call(int characterId) {
    return marvelRepository.getAllSeries(characterId);
  }
}
